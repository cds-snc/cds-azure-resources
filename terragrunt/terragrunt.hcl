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

  # Cognito identities permitted to obtain a token as the AWS forwarder managed
  # identity. One entry per AWS account that runs a forwarder: identity pools
  # carry no resource policy, so a pool cannot be called cross-account.
  #
  # identity_id is the Cognito IdentityId and becomes the federated
  # credential's subject. It does not exist until the pool mints one, which is
  # why these are literals rather than references. Minted 2026-09-09 against
  # the log archive pool (274536870005), keyed on the managed identity's client
  # id as the developer user identifier — the same value the layer sends, which
  # is what makes the mapping deterministic and repeatable.
  sentinel_forwarder_v2_aws_cognito_identities = {
    log_archive = {
      identity_pool_id = "ca-central-1:754cc6c0-afac-48e9-8f0e-10abe6aa1270"
      identity_id      = "ca-central-1:3febac30-753a-c09a-9582-594b28fe7806"
    }
  }
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