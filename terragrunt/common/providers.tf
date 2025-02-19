terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
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
