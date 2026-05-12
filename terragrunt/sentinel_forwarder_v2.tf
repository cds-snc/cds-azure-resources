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
