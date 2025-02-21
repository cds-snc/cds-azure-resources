variable "name" {
  description = "The name of the identity"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group (only required for Managed Identity)"
  type        = string
  default     = null
}

variable "create_service_principal" {
  description = "Set to true to create a Service Principal"
  type        = bool
  default     = false
}

variable "create_managed_identity" {
  description = "Set to true to create a Managed Identity"
  type        = bool
  default     = false
}

variable "role_scope" {
  description = "The scope where the role assignment should be applied"
  type        = string
}

variable "create_custom_role" {
  description = "Set to true to create a custom role"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "The name of the role to assign"
  type        = string
  default     = "Contributor"
}

variable "role_definition_name" {
  description = "The existing role name to assign (ignored if create_custom_role is true)"
  type        = string
  default     = "Reader"
}

variable "role_permissions" {
  description = "The permissions to be assigned in a custom role"
  type        = list(string)
  default     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
}

variable "subscription_id" {
  type        = string
  description = "The subscription ID to create resources in."
}

variable "tenant_id" {
  type        = string
  description = "The tenant ID to create resources in."
}
