# Example of how to create a service principal and assign it the "Contributor" role at the subscription level
module "service_principal" {
  source                   = "./terraform-modules/azure_identity_role"
  name                     = "my-sp"
  create_service_principal = true
  role_scope               = "/subscriptions/YOUR_SUBSCRIPTION_ID"
  role_definition_name     = "Contributor"
}
