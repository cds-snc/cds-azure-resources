# AI Gateway — App Registration + Federated Identity for GitHub Actions OIDC
# Used by cds-snc/ai-gateway workflows to authenticate with Azure via OIDC

resource "azuread_application_registration" "ai_gateway" {
  display_name = "ai-gateway-github-actions"
}

resource "azuread_service_principal" "ai_gateway" {
  client_id = azuread_application_registration.ai_gateway.client_id
}

# Federated Identity Credential for pull_request events
resource "azuread_application_federated_identity_credential" "ai_gateway_github_oidc_pr" {
  application_id = azuread_application_registration.ai_gateway.id
  display_name   = "github-actions-ai-gateway-pr-exact"
  description    = "OIDC for GitHub Actions pull_request in cds-snc/ai-gateway"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:cds-snc/ai-gateway:pull_request"
}

# Federated Identity Credential for pushes to main
resource "azuread_application_federated_identity_credential" "ai_gateway_github_oidc_main" {
  application_id = azuread_application_registration.ai_gateway.id
  display_name   = "github-actions-ai-gateway-main-exact"
  description    = "OIDC for GitHub Actions main branch in cds-snc/ai-gateway"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:cds-snc/ai-gateway:ref:refs/heads/main"
}

# Contributor role on the target subscription so workflows can create resources
resource "azurerm_role_assignment" "ai_gateway_contributor_subscription" {
  scope                = "/subscriptions/c4122b45-f2e3-4873-a7fe-b94c1ad2589f" # CDS-AI sub
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.ai_gateway.object_id
}
