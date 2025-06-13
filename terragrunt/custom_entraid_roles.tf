# Define a custom role for creating unlimited application registrations in Azure AD
module "custom_entraid_roles_appreg" {
  source       = "./modules/custom_entraid_roles"
  display_name = "Application Registration Creator"
  description  = "Can create an unlimited number of application registrations"
  permissions = [
    "microsoft.directory/applications/create",
    "microsoft.directory/applications/createAsOwner"
  ]
  role_version = "1.0"
  enabled      = true
}

# Assign the custom role to the group 'DC Admins'
data "azuread_group" "dc_admins" {
  display_name = "DC Admins"
}

resource "azuread_directory_role_assignment" "appreg_creator_to_dc_admins" {
  role_id             = module.custom_entraid_roles_appreg.object_id
  principal_object_id = data.azuread_group.dc_admins.object_id
}

