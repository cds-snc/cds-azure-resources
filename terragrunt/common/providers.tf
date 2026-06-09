terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.38.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.8.0"
    }
  }
}

provider "azapi" {
  use_msi = false
}

# Aliased providers for OpenAI module instances that target subscriptions
# other than the default (CDS-SNC-Management) provider defined in
# scheduled_query_alert_rules.tf.

provider "azurerm" {
  alias                           = "sre_tools"
  subscription_id                 = "204b7832-86f3-4792-8e35-860862258324"
  resource_provider_registrations = "none"
  features {}
}

provider "azurerm" {
  alias                           = "dto"
  subscription_id                 = "5617b0eb-50cc-4fe6-b57e-021e6ec245f0"
  resource_provider_registrations = "none"
  features {}
}

provider "azurerm" {
  alias                           = "cds-ai"
  subscription_id                 = "c4122b45-f2e3-4873-a7fe-b94c1ad2589f"
  resource_provider_registrations = "none"
  features {}
}

