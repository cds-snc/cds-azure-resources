# AI Gateway — App Registration + Federated Identity for GitHub Actions OIDC
# Used by cds-snc/ai-gateway workflows to authenticate with Azure via OIDC

resource "azuread_application_registration" "ai_gateway" {
  display_name = "ai-gateway-github-actions"
}

resource "azuread_service_principal" "ai_gateway" {
  client_id = azuread_application_registration.ai_gateway.client_id
}

# Flexible Federated Identity Credential for the ai-gateway repository
resource "azuread_application_flexible_federated_identity_credential" "ai_gateway_github_oidc" {
  application_id             = azuread_application_registration.ai_gateway.id
  display_name               = "github-actions-ai-gateway"
  description                = "OIDC for GitHub Actions in cds-snc/ai-gateway"
  audience                   = "api://AzureADTokenExchange"
  issuer                     = "https://token.actions.githubusercontent.com"
  claims_matching_expression = "claims['sub'] matches 'repo:cds-snc/ai-gateway:*'"
}
