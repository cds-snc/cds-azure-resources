output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.service_health.id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.service_health.name
}

output "activity_log_alert_id" {
  description = "The ID of the service health activity log alert"
  value       = azurerm_monitor_activity_log_alert.service_health.id
}

output "activity_log_alert_name" {
  description = "The name of the service health activity log alert"
  value       = azurerm_monitor_activity_log_alert.service_health.name
}
