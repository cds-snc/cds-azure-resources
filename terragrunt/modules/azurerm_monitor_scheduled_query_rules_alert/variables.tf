variable "subscription_id" {
  description = "The subscription ID to use for the provider"
  type        = string
}

variable "name" {
  description = "The name of the scheduled query rule alert"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resource should be created"
  type        = string
}

variable "evaluation_frequency" {
  description = "How often the scheduled query rule is evaluated"
  type        = string
  default     = "PT5M"
}

variable "window_duration" {
  description = "The period of time on which the alert query will be executed"
  type        = string
  default     = "PT5M"
}

variable "scopes" {
  description = "The list of resource IDs that this scheduled query rule is scoped to"
  type        = list(string)
}

variable "severity" {
  description = "The severity of the alert (0-4)"
  type        = number
  default     = 3
  
  validation {
    condition     = var.severity >= 0 && var.severity <= 4
    error_message = "Severity must be between 0 and 4."
  }
}

variable "operator" {
  description = "The operator used to compare the query result with the threshold"
  type        = string
  default     = "GreaterThan"
  
  validation {
    condition = contains([
      "Equals", "GreaterThan", "GreaterThanOrEqual", 
      "LessThan", "LessThanOrEqual"
    ], var.operator)
    error_message = "Operator must be one of: Equals, GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual."
  }
}

variable "query" {
  description = "The KQL query to be executed"
  type        = string
}

variable "time_aggregation_method" {
  description = "The aggregation method to apply to the query result"
  type        = string
  default     = "Count"
  
  validation {
    condition = contains([
      "Average", "Count", "Maximum", "Minimum", "Total"
    ], var.time_aggregation_method)
    error_message = "Time aggregation method must be one of: Average, Count, Maximum, Minimum, Total."
  }
}

variable "threshold" {
  description = "The threshold value for the alert"
  type        = number
}

variable "enabled" {
  description = "Whether the scheduled query rule is enabled"
  type        = bool
  default     = true
}

variable "action_groups" {
  description = "List of action group IDs to trigger when the alert fires"
  type        = list(string)
  default     = null
}

variable "custom_properties" {
  description = "Custom properties to include with the alert"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
