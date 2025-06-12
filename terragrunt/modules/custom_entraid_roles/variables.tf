variable "display_name" {
  description = "The display name for the custom directory role."
  type        = string
}

variable "description" {
  description = "The description for the custom directory role."
  type        = string
  default     = null
}

variable "permissions" {
  description = "A set of permission values to assign to the role."
  type        = set(string)
}

variable "enabled" {
  description = "Whether the custom directory role is enabled."
  type        = bool
  default     = true
}

variable "role_version" {
  description = "The version of the custom directory role."
  type        = string
  default     = "1.0"
}
variable "tenant_id" {
  type        = string
  description = "The tenant ID to create resources in."
  default     = null
}
