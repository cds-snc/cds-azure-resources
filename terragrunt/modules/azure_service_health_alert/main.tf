# Resource Group for Service Health resources
resource "azurerm_resource_group" "service_health" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Service Health Activity Log Alert
resource "azurerm_monitor_activity_log_alert" "service_health" {
  name                = var.alert_name
  resource_group_name = azurerm_resource_group.service_health.name
  location            = "global" # Activity log alerts must be global
  description         = var.alert_description
  enabled             = var.enabled
  scopes              = ["/subscriptions/${var.subscription_id}"]
  tags                = var.tags

  action {
    action_group_id = var.action_group_id
  }

  criteria {
    category = "ServiceHealth"

    service_health {
      events    = var.service_health_events
      locations = var.service_health_locations
      services  = var.service_health_services
    }
  }
}
