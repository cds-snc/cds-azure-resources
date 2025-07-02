module "conditional_access_policy_modification" {
  source = "./modules/azurerm_monitor_scheduled_query_rules_alert"

  subscription_id     = var.subscription_id
  name               = "Conditional Access Policy Modification"
  resource_group_name = var.resource_group_name
  location           = var.location

  evaluation_frequency = "PT10M"
  window_duration     = "PT10M"
  scopes             = [var.log_analytics_workspace_id]
  severity           = 2

  operator                = "GreaterThan"
  threshold              = 0
  query                  = "AuditLogs | where OperationName in (\"Update conditional access policy\", \"Add conditional access policy\", \"Delete conditional access policy\")
"
  time_aggregation_method = "Count"

  enabled = true

  action_groups = var.action_group_ids

  tags = var.common_tags
}

module "breakglass_account_signin_attempt" {
  source = "./modules/azurerm_monitor_scheduled_query_rules_alert"

  subscription_id     = var.subscription_id
  name               = "Breakglass Account Signin Attempt"
  resource_group_name = var.resource_group_name
  location           = var.location

  evaluation_frequency = "PT10M"
  window_duration     = "PT10M"
  scopes             = [var.log_analytics_workspace_id]
  severity           = 2

  operator                = "GreaterThan"
  time_aggregation_method = "Count"
  threshold              = 0
  query = "SigninLogs | where UserPrincipalName in ('ops1@cdssnc.onmicrosoft.com','ops2@cdssnc.onmicrosoft.com')"

  enabled = true

  action_groups     = var.security_action_group_ids
  custom_properties = {
    "AlertCategory" = "Security"
    "EventType"     = "FailedLogin"
  }

  tags = var.common_tags
}