# Conditional Access Policies variables
variable "policy_name" {
  description = "Name of the conditional access policy"
  type        = string
}

variable "client_app_types" {
  description = "List of client app types"
  type        = list(string)
}

variable "included_applications" {
  description = "List of included applications"
  type        = list(string)
}

variable "excluded_applications" {
  description = "List of excluded applications"
  type        = list(string)
  default     = []
}

variable "included_locations" {
  description = "List of included locations"
  type        = list(string)
}

variable "excluded_locations" {
  description = "List of excluded locations"
  type        = list(string)
  default     = []
}

variable "included_platforms" {
  description = "List of included platforms"
  type        = list(string)
}

variable "excluded_platforms" {
  description = "List of excluded platforms"
  type        = list(string)
  default     = []
}

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

variable "excluded_groups" {
  description = "List of excluded groups"
  type        = list(string)
  default     = []
}

variable "built_in_controls" {
  description = "List of built-in controls"
  type        = list(string)
}

variable "operator" {
  description = "Operator for grant controls"
  type        = string
}
