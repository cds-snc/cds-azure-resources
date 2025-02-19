# Output the resource group name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# output the Azure Cognitive Services account name
output "azurerm_cognitive_account_id" {
  value = azurerm_cognitive_account.openai.id
}

# ouptput the endpoint of the Azure Cognitive Services account
output "azurerm_cognitive_account_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}
