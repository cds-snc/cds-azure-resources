locals {
  cost_center_code     = "azure-cds-resources"
  client_id            = get_env("ARM_CLIENT_ID")
  subscription_id      = get_env("ARM_TF_STATE_SUBSCRIPTION_ID")
  tenant_id            = get_env("ARM_TENANT_ID")
  resource_group_name  = get_env("AZURE_RESOURCES_RESOURCE_GROUP_NAME")
  storage_account_name = get_env("AZURE_RESOURCES_STORAGE_ACCOUNT_NAME")
  division_tags = {
    internal_sre        = "CDS"
    digital_credentials = "DC"
  }
}

inputs = {
  cost_center_code = local.cost_center_code
  tenant_id        = local.tenant_id
  root_id          = "cds-snc"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = file("./common/providers.tf")
}

generate "common_variables" {
  path      = "common_variables.tf"
  if_exists = "overwrite"
  contents  = file("${get_terragrunt_dir()}/./common/common_variables.tf")
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {

    resource_group_name  = local.resource_group_name
    storage_account_name = local.storage_account_name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    subscription_id      = local.subscription_id
    tenant_id            = local.tenant_id
    client_id            = local.client_id
    use_oidc             = true
  }
}