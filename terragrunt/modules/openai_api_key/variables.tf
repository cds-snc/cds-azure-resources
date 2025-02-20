variable "sku" {
  type        = string
  description = "The sku name of the Azure Analysis Services server to create. For Open AI, the sku is S0. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
  default     = "S0"
}

variable "resource_group_location" {
  type        = string
  description = "Location for all resources."
  default     = "canadaeast"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "rg"
}

variable "custom_subdomain_name" {
  type        = string
  description = "The custom subdomain name for the Cognitive Services account. If not specified, a random one will be generated."
}

variable "name" {
  type        = string
  description = "The name of the Cognitive Services account. If not specified, a random one will be generated."
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID to create the Azure Cognitive Services account."
}

variable "openai_deployments" {
  description = "(Optional) Specifies the deployments of the Azure OpenAI Service"
  type = list(object({
    name = string
    model = object({
      name    = string
      version = string
    })
    rai_policy_name = string
  }))
  default = [
    {
      name = "openai-gpt4o-mini"
      model = {
        name    = "gpt-4o-mini"
        version = "2024-07-18"
      }
      rai_policy_name = ""
    }
  ]
}
