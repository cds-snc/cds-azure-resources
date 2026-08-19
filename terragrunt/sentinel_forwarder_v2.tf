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
# federated from Amazon Cognito.
#
# Used by the AWS forwarders (cds-snc/aws-sentinel-connector-layer) to reach the
# Logs Ingestion API with no stored secret. A Lambda calls
# cognito-identity:GetOpenIdTokenForDeveloperIdentity with only its IAM role,
# then presents the resulting OIDC JWT to Entra as a client_assertion to get a
# token for this identity.
#
# A managed identity rather than an app registration because a managed identity
# cannot hold a client secret or certificate at all, so "no stored secret" is a
# property of the object rather than a policy someone has to keep enforcing.
# ---------------------------------------------------------------------------

resource "azurerm_user_assigned_identity" "sentinel_forwarder_v2_aws_cognito" {
  name                = "sentinel-forwarder-v2-aws-cognito"
  resource_group_name = data.azurerm_resource_group.cds_snc_mgmt.name
  location            = var.primary_location
  tags                = local.common_tags
}

# Scoped to the whole resource group so one identity covers every DCR in
# cds-snc-mgmt, current and future, without a grant per forwarder.
#
# Two consequences to be aware of, both accepted deliberately:
#   - reach: this covers all DCRs in the group, not only the AWS ones;
#   - permanence: cds-snc-mgmt carries a CanNotDelete lock, which blocks
#     deleting role assignments as well as resources (`az role assignment
#     delete` returns ScopeLocked), so this grant cannot be removed while the
#     lock stands.
resource "azurerm_role_assignment" "sentinel_forwarder_v2_aws_cognito_metrics_publisher" {
  scope                = data.azurerm_resource_group.cds_snc_mgmt.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_cognito.principal_id
}

# One credential per Cognito identity permitted to act as this managed identity.
#
# The subject is the Cognito IdentityId, which does not exist until the pool
# mints one — so the order is: create the pool in the Lambda's own AWS account,
# let it mint an identity, then add it here. Identity pools have no resource
# policy, so a pool cannot be called cross-account; each AWS account running a
# forwarder needs its own pool and therefore its own entry.
variable "sentinel_forwarder_v2_aws_cognito_identities" {
  description = "Cognito identities allowed to obtain a token as the AWS forwarder managed identity. Key is a short label (typically the AWS account or forwarder name); identity_pool_id becomes the credential audience and identity_id its subject."
  type = map(object({
    identity_pool_id = string
    identity_id      = string
  }))
  default = {}
}

resource "azurerm_federated_identity_credential" "sentinel_forwarder_v2_aws_cognito" {
  for_each = var.sentinel_forwarder_v2_aws_cognito_identities

  name                      = "aws-cognito-${each.key}"
  user_assigned_identity_id = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_cognito.id
  audience                  = [each.value.identity_pool_id]
  issuer                    = "https://cognito-identity.amazonaws.com"
  subject                   = each.value.identity_id
}

# The Lambda needs the client id as ARM_CLIENT_ID; it is also the developer user
# identifier passed to Cognito, which keeps the IdentityId mapping deterministic.
output "sentinel_forwarder_v2_aws_cognito_client_id" {
  description = "Client id of the AWS forwarder managed identity — the Lambda's ARM_CLIENT_ID."
  value       = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_cognito.client_id
}

output "sentinel_forwarder_v2_aws_cognito_principal_id" {
  description = "Object id of the AWS forwarder managed identity, for role assignments outside this module."
  value       = azurerm_user_assigned_identity.sentinel_forwarder_v2_aws_cognito.principal_id
}
