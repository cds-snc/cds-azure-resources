# This is an example of how to use the service_principal_custom_role module to create a custom role and assign it to a service principal.
# This example creates a custom role named "CustomReadOnly" with the permission to read resource groups.
# The service principal is created and assigned the custom role at the subscription level.
module "service_principal_custom_role" {
  source                   = "./terraform-modules/azure_identity_role"
  name                     = "custom-sp"
  create_service_principal = true
  role_scope               = "/subscriptions/YOUR_SUBSCRIPTION_ID"
  create_custom_role       = true
  role_name                = "CustomReadOnly"
  role_permissions         = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
}
