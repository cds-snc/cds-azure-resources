# Conditional Access Policies variables

# Required
variable "policy_name" {
  description = "Name of the conditional access policy"
  type        = string
}

variable "client_app_types" {
  description = "List of client app types (required)"
  type        = list(string)
}

variable "built_in_controls" {
  description = "List of built-in controls"
  type        = list(string)
}

variable "operator" {
  description = "Operator for grant controls"
  type        = string
}

# Optional - state
variable "state" {
  description = "State of the policy: enabled, disabled, or enabledForReportingButNotEnforced"
  type        = string
  default     = "enabled"
}

# Optional - users (at least one included_* is required)
variable "included_users" {
  description = "List of included users"
  type        = list(string)
  default     = []
}

variable "included_groups" {
  description = "List of included groups"
  type        = list(string)
  default     = []
}

variable "included_roles" {
  description = "List of included roles"
  type        = list(string)
  default     = []
}

variable "excluded_users" {
  description = "List of excluded users"
  type        = list(string)
  default     = []
}

variable "excluded_guests_or_external_users" {
  description = "Excluded guests or external users configuration"
  type = object({
    external_tenants              = list(string)
    guests_or_external_user_types = list(string)
  })
  default = null
}

variable "excluded_groups" {
  description = "List of excluded groups"
  type        = list(string)
  default     = []
}

variable "excluded_roles" {
  description = "List of excluded roles"
  type        = list(string)
  default     = []
}

# Optional - applications
variable "included_applications" {
  description = "List of included applications"
  type        = list(string)
  default     = null
}

variable "excluded_applications" {
  description = "List of excluded applications"
  type        = list(string)
  default     = []
}

# Optional - locations
variable "included_locations" {
  description = "List of included locations"
  type        = list(string)
  default     = null
}

variable "excluded_locations" {
  description = "List of excluded locations"
  type        = list(string)
  default     = []
}

# Optional - platforms
variable "included_platforms" {
  description = "List of included platforms"
  type        = list(string)
  default     = null
}

variable "excluded_platforms" {
  description = "List of excluded platforms"
  type        = list(string)
  default     = []
}

# Optional - device filter
variable "device_filter" {
  description = "Device filter rule"
  type = object({
    mode = string
    rule = string
  })
  default = null
}
