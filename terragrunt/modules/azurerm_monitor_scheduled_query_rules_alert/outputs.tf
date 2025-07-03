output "id" {
  description = "The ID of the scheduled query rule alert"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.this.id
}

output "name" {
  description = "The name of the scheduled query rule alert"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.this.name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.this.resource_group_name
}

output "location" {
  description = "The Azure region where the resource is created"
  value       = azurerm_monitor_scheduled_query_rules_alert_v2.this.location
}