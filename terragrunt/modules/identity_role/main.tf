
locals {
  tenant_id = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
}

#========== PROVIDERS ==========
provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  features {}
}
provider "azuread" {
  tenant_id = local.tenant_id
}

# Get the current client configuration from the AzureRM provider.

data "azurerm_client_config" "current" {}

# ========== CONDITIONAL SERVICE PRINCIPAL CREATION ==========
resource "azuread_application" "sp_app" {
  count        = var.create_service_principal ? 1 : 0
  display_name = var.name
}

resource "azuread_service_principal" "sp" {
  count     = var.create_service_principal ? 1 : 0
  client_id = azuread_application.sp_app[0].client_id
}

resource "azuread_service_principal_password" "sp_password" {
  count                = var.create_service_principal ? 1 : 0
  service_principal_id = azuread_service_principal.sp[0].id
}

# ========== CONDITIONAL MANAGED IDENTITY CREATION ==========
resource "azurerm_user_assigned_identity" "managed_identity" {
  count               = var.create_managed_identity ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# ========== CONDITIONAL ROLE CREATION ==========
resource "azurerm_role_definition" "custom_role" {
  count       = var.create_custom_role ? 1 : 0
  name        = var.role_name
  scope       = var.role_scope
  description = "Custom role for ${var.name}"

  permissions {
    actions     = var.role_permissions
    not_actions = []
  }

  assignable_scopes = [var.role_scope]
}

# ========== ROLE ASSIGNMENT TO IDENTITY ==========
resource "azurerm_role_assignment" "role_assignment_sp" {
  count                = var.create_service_principal ? 1 : 0
  scope                = var.role_scope
  role_definition_name = var.create_custom_role ? azurerm_role_definition.custom_role[0].name : var.role_definition_name
  principal_id         = azuread_service_principal.sp[0].object_id
}

resource "azurerm_role_assignment" "role_assignment_mi" {
  count                = var.create_managed_identity ? 1 : 0
  scope                = var.role_scope
  role_definition_name = var.create_custom_role ? azurerm_role_definition.custom_role[0].name : var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.managed_identity[0].principal_id
}
