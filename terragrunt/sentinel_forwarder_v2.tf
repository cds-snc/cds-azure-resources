# Sentinel Forwarder v2 — App Registration + Federated Identity for GitHub Actions OIDC
# Used by cds-snc/sentinel-forward-data-action to forward logs via the v2 Logs Ingestion API

resource "azuread_application_registration" "sentinel_forwarder_v2" {
  display_name = "sentinel-forwarder-v2-github-actions"
}

resource "azuread_service_principal" "sentinel_forwarder_v2" {
  client_id = azuread_application_registration.sentinel_forwarder_v2.client_id
}

# Flexible Federated Identity Credential — one credential covers all cds-snc repos
resource "azuread_application_flexible_federated_identity_credential" "github_oidc" {
  application_id             = azuread_application_registration.sentinel_forwarder_v2.id
  display_name               = "github-actions-cds-snc-all-repos"
  description                = "OIDC for sentinel-forward-data-action across all cds-snc repos"
  audience                   = "api://AzureADTokenExchange"
  issuer                     = "https://token.actions.githubusercontent.com"
  claims_matching_expression = "claims['sub'] matches 'repo:cds-snc/*'"
}

# Monitoring Metrics Publisher role on the cds-snc-mgmt resource group
data "azurerm_resource_group" "cds_snc_mgmt" {
  name = local.resource_group_name
}

resource "azurerm_role_assignment" "sentinel_forwarder_v2_metrics_publisher" {
  scope                = data.azurerm_resource_group.cds_snc_mgmt.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azuread_service_principal.sentinel_forwarder_v2.object_id
}

# ---------------------------------------------------------------------------
# Sentinel Forwarder v2 — User-Assigned Managed Identity for AWS Lambda,
# federated from the hub role in Log Archive.
#
# Used by the AWS forwarders (cds-snc/aws-sentinel-connector-layer) to reach the
# Logs Ingestion API with no stored secret. Every forwarder assumes one role in
# Log Archive, sentinel-forwarder-hub, and calls sts:GetWebIdentityToken
# through that account's IAM outbound identity federation. The token's subject is always the hub role's ARN, so one
# credential here covers every AWS account, with no mint step.
#
# Which accounts may send data is decided in AWS, by the hub role's trust
# policy (cds-snc/cds-aws-lz, terragrunt/org_account/main/sentinel_forwarder_hub.tf).
# This side only checks the token's issuer, subject and audience.
#
# It replaced sentinel-forwarder-v2-aws-cognito, an identity federated from a
# Cognito pool in each forwarder's account, removed once every pool was gone.
# Design: cds-snc/sentinel-connectors, docs/aws-forwarder-hub-federation-design.md
# ---------------------------------------------------------------------------

locals {
  # Outputs of cds-aws-lz org_account/main. The issuer is fixed per AWS
  # account: disabling and re-enabling federation returns the same URL.
  sentinel_forwarder_v2_aws_hub_issuer   = "https://a1bc78a0-abfb-4482-a855-63201c908f74.tokens.sts.global.api.aws"
  sentinel_forwarder_v2_aws_hub_role_arn = "arn:aws:iam::274536870005:role/sentinel-forwarder-hub"
}

resource "azurerm_user_assigned_identity" "sentinel_forwarder_v2_aws_hub" {
  name                = "sentinel-forwarder-v2-aws-hub"
  resource_group_name = data.azurerm_resource_group.cds_snc_mgmt.name
  location            = var.primary_location
  tags                = local.common_tags
}

# Scoped to the whole resource group so one identity covers every DCR in
# cds-snc-mgmt, current and future, without a grant per forwarder. It reaches
# every DCR in the group, not only the AWS ones. The group's CanNotDelete lock
# blocks deleting role assignments too; the apply workflow lifts it.
resource "azurerm_role_assignment" "sentinel_forwarder_v2_aws_hub_metrics_publisher" {
  scope                = data.azurerm_resource_group.cds_snc_mgmt.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_hub.principal_id
}

resource "azurerm_federated_identity_credential" "sentinel_forwarder_v2_aws_hub" {
  name                      = "aws-log-archive-hub"
  user_assigned_identity_id = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_hub.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = local.sentinel_forwarder_v2_aws_hub_issuer
  subject                   = local.sentinel_forwarder_v2_aws_hub_role_arn
}

output "sentinel_forwarder_v2_aws_hub_client_id" {
  description = "Client id of the hub-federated AWS forwarder managed identity — the Lambda's AZURE_CLIENT_ID."
  value       = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_hub.client_id
}

output "sentinel_forwarder_v2_aws_hub_principal_id" {
  description = "Object id of the hub-federated AWS forwarder managed identity, for role assignments and sign-in log alerts."
  value       = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_hub.principal_id
}
