# This Terraform module is used to manage Azure identities and roles.
# It includes conditional creation of service principals, managed identities,
# custom roles, and role assignments based on the provided variables.

# Local Variables:
# - tenant_id: The tenant ID to use, either from the provided variable or the current AzureRM client configuration.

# Providers:
# - azurerm: Configured with the subscription ID and features.
# - azuread: Configured with the tenant ID.

# Data Sources:
# - azurerm_client_config: Retrieves the current client configuration from the AzureRM provider.

# Resources:
# - azuread_application.sp_app: Conditionally creates an Azure AD application for the service principal.
# - azuread_service_principal.sp: Conditionally creates a service principal for the Azure AD application.
# - azuread_service_principal_password.sp_password: Conditionally creates a password for the service principal.
# - azurerm_user_assigned_identity.managed_identity: Conditionally creates a user-assigned managed identity.
# - azurerm_role_definition.custom_role: Conditionally creates a custom role definition.
# - azurerm_role_assignment.role_assignment_sp: Conditionally assigns a role to the service principal.
# - azurerm_role_assignment.role_assignment_mi: Conditionally assigns a role to the managed identity.

# Variables:
# - tenant_id: The tenant ID to use (optional).
# - subscription_id: The subscription ID to use.
# - create_service_principal: Boolean to determine if a service principal should be created.
# - create_managed_identity: Boolean to determine if a managed identity should be created.
# - create_custom_role: Boolean to determine if a custom role should be created.
# - name: The name to use for the service principal or managed identity.
# - resource_group_name: The resource group name for the managed identity.
# - location: The location for the managed identity.
# - role_name: The name of the custom role.
# - role_scope: The scope for the custom role and role assignments.
# - role_permissions: The permissions for the custom role.
# - role_definition_name: The name of the role definition to assign if not creating a custom role.


# Define a local value `tenant_id` which is set to the value of the `tenant_id` variable if it is provided.
# If the `tenant_id` variable is not provided, it defaults to the tenant ID of the current Azure client configuration.
locals {
  tenant_id = coalesce(var.tenant_id, data.azurerm_client_config.current.tenant_id)
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
