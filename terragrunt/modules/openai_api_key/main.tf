# Define the provider configuration

provider "azurerm" {
  skip_provider_registration = true
  features {}
  subscription_id = var.subscription_id
}

# Get the current client configuration from the AzureRM provider.

data "azurerm_client_config" "current" {}

# This configuration generates a random string that is appended to resource names to ensure uniqueness, 
# and then creates an Azure resource group and a Cognitive Services account of kind OpenAI. It conditionally 
# uses user-supplied names or defaults to the random string, while also appending a user-defined prefix to the 
# resource group name.

# Create a random string to use in the resource group name
resource "random_string" "azurerm_cognitive_account_name" {
  length  = 7
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Resource group
resource "azurerm_resource_group" "rg" {
  name     = "${random_string.azurerm_cognitive_account_name.result}-${var.resource_group_name_prefix}"
  location = var.resource_group_location
}


# Create the Azure Cognitive Services account with OpenAI kind
resource "azurerm_cognitive_account" "openai" {
  # if name is provided by the user, use it; otherwise, generate a random name
  name                  = var.name != "" ? "${var.name}-${random_string.azurerm_cognitive_account_name.result}" : random_string.azurerm_cognitive_account_name.result
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  custom_subdomain_name = var.custom_subdomain_name != "" ? "${var.custom_subdomain_name}-${random_string.azurerm_cognitive_account_name.result}" : random_string.azurerm_cognitive_account_name.result
  kind                  = "OpenAI" # Specifies an OpenAI resource
  sku_name              = var.sku  # SKU; adjust as needed
}

# Select and deploy the OpenAI model to the Cognitive Services account
resource "azurerm_cognitive_deployment" "deployment" {
  for_each = { for deployment in var.openai_deployments : deployment.name => deployment }

  name                 = each.key
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = each.value.model.name
    version = each.value.model.version
  }

  scale {
    type     = "GlobalStandard"
    capacity = 50 # Represents 50,000 TPM
  }
}

# Create a budget alarm with default of $25/month
resource "azurerm_consumption_budget_resource_group" "openai_budget" {
  name              = "openai-budget"
  resource_group_id = azurerm_resource_group.rg.id
  amount            = var.budget_amount
  time_grain        = var.budget_time_grain

  # Let the budget alarm expire in 10 years. We basically want to send the budget alarm to the user for indeterminate, which is currently max 10 years in the settings.
  time_period {
    start_date = "2025-02-01T00:00:00Z"
    end_date   = "2035-02-01T00:00:00Z"
  }
  notification {
    enabled        = true
    threshold      = 80
    operator       = "EqualTo"
    threshold_type = "Forecasted"
    # Send notifications to the SRE team and requestor email(s) when we are at 80% of the forecasted budget
    contact_emails = concat(
      ["sre-ifs@cds-snc.ca"],
      var.requestor_emails
    )
  }
}
