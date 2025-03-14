terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.23.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13.1"
    }
  }
}

provider "azapi" {
  use_msi = false
}
