locals {
  subscription_id     = "6881deca-df81-4b95-ad54-103b0b100a1d" #CDS-SNC-Management
  resource_group_name = "cds-snc-mgmt"
  action_group_ids    = [resource.azurerm_monitor_action_group.SRE_GR_AG.id]

  common_tags = {
    ClientOrganization = "cds-snc"
    CostCenter         = "sentinel"
    DataSensitivity    = "U"
    ProjectContact     = "Security@CDS"
    ProjectName        = "Sentinel"
    TechnicalContact   = var.security_email
    ssc_cbrid          = "21JA"
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id                 = local.subscription_id
  features {
  }
}
# Get the current client configuration from the AzureRM provider.
data "azurerm_client_config" "current" {}


data "azurerm_log_analytics_workspace" "this" {
  name                = "cds-snc-la"
  resource_group_name = local.resource_group_name
}

resource "azurerm_monitor_action_group" "SRE_GR_AG" {
  enabled             = true
  location            = "global"
  name                = "SRE-GR-AG"
  resource_group_name = local.resource_group_name
  short_name          = "Guardrails"
  tags                = local.common_tags
  email_receiver {
    email_address           = var.sre_email
    name                    = "Internal SRE_-EmailAction-"
    use_common_alert_schema = false
  }
}

module "conditional_access_policy_modification" {
  source = "./modules/azurerm_monitor_scheduled_query_rules_alert"

  subscription_id     = local.subscription_id
  name                = "Conditional Access Policy Modification"
  resource_group_name = local.resource_group_name

  evaluation_frequency = "PT10M"
  window_duration      = "PT10M"
  scopes               = [data.azurerm_log_analytics_workspace.this.id]
  severity             = 2

  operator                = "GreaterThan"
  time_aggregation_method = "Count"
  threshold               = 0
  query                   = "AuditLogs | where OperationName in (\"Update conditional access policy\", \"Add conditional access policy\", \"Delete conditional access policy\")"

  enabled = true

  action_groups = local.action_group_ids
  tags          = local.common_tags
}


module "breakglass_account_signin_attempt" {
  source = "./modules/azurerm_monitor_scheduled_query_rules_alert"

  subscription_id     = local.subscription_id
  name                = "Breakglass Account Signin Attempt"
  resource_group_name = local.resource_group_name

  evaluation_frequency = "PT10M"
  window_duration      = "PT10M"
  scopes               = [data.azurerm_log_analytics_workspace.this.id]
  severity             = 2

  operator                = "GreaterThan"
  time_aggregation_method = "Count"
  threshold               = 0
  query                   = "SigninLogs | where UserPrincipalName in ('ops1@cdssnc.onmicrosoft.com','ops2@cdssnc.onmicrosoft.com')"

  enabled = true

  action_groups = local.action_group_ids
  tags          = local.common_tags
}
