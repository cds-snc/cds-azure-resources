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

variable "operator" {
  description = "Operator for grant controls"
  type        = string
}

# Optional - grant controls (set built_in_controls, authentication_strength_policy_id, or both)
variable "built_in_controls" {
  description = "List of built-in controls"
  type        = list(string)
  default     = null
}

variable "authentication_strength_policy_id" {
  description = "ID of the authentication strength policy to require, e.g. /policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000004 for the built-in Phishing-resistant MFA"
  type        = string
  default     = null
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

# Optional - user risk levels
variable "user_risk_levels" {
  description = "List of user risk levels (low, medium, high, none)"
  type        = list(string)
  default     = []
}

# Optional - authentication flows
variable "authentication_flow_transfer_methods" {
  description = "List of authentication flow transfer methods to include (e.g. deviceCodeFlow, authenticationTransfer)"
  type        = list(string)
  default     = []
}

# Optional - sign-in risk levels
variable "sign_in_risk_levels" {
  description = "List of sign-in risk levels (low, medium, high, none)"
  type        = list(string)
  default     = []
}

# Optional - session controls
variable "sign_in_frequency" {
  description = "Sign-in frequency configuration"
  type = object({
    value               = optional(number)
    type                = optional(string)
    authentication_type = optional(string)
    frequency_interval  = optional(string)
  })
  default = null
}
