# # terraform {
# #   required_providers {
# #     azurerm = {
# #       source  = "hashicorp/azurerm"
# #       version = "~>3.0"
# #     }
# #     random = {
# #       source  = "hashicorp/random"
# #       version = "~>3.0"
# #     }
# #   }
# # }

# # provider "azurerm" {
# #   features {}
# # }

# terraform {
#   required_providers {

#     azuread = {
#       source  = "hashicorp/azuread"
#       version = "2.53.1"
#     }

#   }

# }


# provider "azuread" {
#   tenant_id = local.tenant_id
# }

# provider "azurerm" {
#   features {
#     resource_group {
#       prevent_deletion_if_contains_resources = true
#     }
#     template_deployment {
#       delete_nested_items_during_deletion = false
#     }
#   }
# }

# data "azuread_client_config" "current" {}

# data "azurerm_client_config" "current" {
# }

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
