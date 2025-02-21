module "service_principal_custom_role" {
  source                   = "./terraform-modules/azure_identity_role"
  name                     = "custom-sp"
  create_service_principal = true
  role_scope               = "/subscriptions/YOUR_SUBSCRIPTION_ID"
  create_custom_role       = true
  role_name                = "CustomReadOnly"
  role_permissions         = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
}
