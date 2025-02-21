module "managed_identity" {
  source                  = "./terraform-modules/azure_identity_role"
  name                    = "my-mi"
  create_managed_identity = true
  resource_group_name     = "my-rg"
  location                = "East US"
  role_scope              = "/subscriptions/YOUR_SUBSCRIPTION_ID"
  role_definition_name    = "Reader"
}
