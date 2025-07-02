# Define the provider configuration

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  subscription_id = var.subscription_id
}

# Get the current client configuration from the AzureRM provider.

data "azurerm_client_config" "current" {}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  evaluation_frequency = var.evaluation_frequency
  window_duration      = var.window_duration
  scopes               = var.scopes
  severity             = var.severity
  
  criteria {
    operator                = var.operator
    query                   = var.query
    time_aggregation_method = var.time_aggregation_method
    threshold               = var.threshold
  }

  enabled = var.enabled

  dynamic "action" {
    for_each = var.action_groups != null ? [1] : []
    content {
      action_groups     = var.action_groups
      custom_properties = var.custom_properties
    }
  }

  tags = var.tags
}
