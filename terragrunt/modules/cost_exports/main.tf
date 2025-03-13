# Define the provider configuration

provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  features {}
}

# Get the current client configuration from the AzureRM provider.

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "cost_exports_rg" {
  name     = "cost-exports-rg"
  location = var.primary_location
}

resource "azurerm_storage_account" "cost_exports_storage" {
  name                = "cdscostexportsstorage"
  resource_group_name = azurerm_resource_group.cost_exports_rg.name

  location                 = var.primary_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "cost_exports_container" {
  name                 = "cost-exports-container"
  storage_account_name = azurerm_storage_account.cost_exports_storage.name
}


resource "azurerm_billing_account_cost_management_export" "this" {
  name               = var.name
  billing_account_id = var.billing_account_id

  recurrence_type              = var.recurrence_type
  recurrence_period_start_date = var.recurring_period_start_date
  recurrence_period_end_date   = var.recurring_period_end_date

  export_data_options {
    type       = var.type
    time_frame = var.time_frame
  }

  export_data_storage_location {
    container_id     = azurerm_storage_container.cost_exports_container.id
    root_folder_path = var.root_folder_path
  }
}
