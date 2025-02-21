module "saas_app_service_principal" {
  source                   = "./modules/identity_role"
  name                     = "saas-app-service_principal"
  create_service_principal = true
  subscription_id          = "0bbd06bc-48ac-48bc-9275-c0cbeebef3b6" # Scratch subscription for testing
  location                 = var.region
  role_scope               = "/subscriptions/0bbd06bc-48ac-48bc-9275-c0cbeebef3b6"
  role_definition_name     = "Reader"
  tenant_id                = var.tenant_id
}
