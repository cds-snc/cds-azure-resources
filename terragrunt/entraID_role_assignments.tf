
# Assign Groups Administrator role to Eric 
data "azuread_user" "eric" {
  user_principal_name = "eric.ehret@cdssnc.onmicrosoft.com"
}

resource "azuread_directory_role" "groups_admin" {
  display_name = "Groups administrator"
}

resource "azuread_directory_role_assignment" "eric_groups_admin" {
  role_id             = azuread_directory_role.groups_admin.template_id
  principal_object_id = data.azuread_user.eric.object_id
}
