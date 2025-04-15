output "billing_account_cost_export_id" {
  description = "The resource ID of the billing account cost management export."
  value       = azurerm_billing_account_cost_management_export.this.id
}

output "billing_account_cost_export_name" {
  description = "The name of the cost export."
  value       = azurerm_billing_account_cost_management_export.this.name
}
