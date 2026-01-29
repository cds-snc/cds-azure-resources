terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.58.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.7.0"
    }
  }
}

provider "azapi" {
  use_msi = false
}
