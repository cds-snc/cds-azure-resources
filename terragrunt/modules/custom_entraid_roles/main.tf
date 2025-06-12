provider "azuread" {
  tenant_id = var.tenant_id
}

resource "azuread_custom_directory_role" "this" {
  display_name = var.display_name
  description  = var.description
  enabled      = var.enabled
  version      = var.role_version

  permissions {
    allowed_resource_actions = var.permissions
  }
}
