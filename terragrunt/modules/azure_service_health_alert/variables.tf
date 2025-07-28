variable "subscription_id" {
  description = "The subscription ID to create the service health alert for"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the resources will be created"
  type        = string
  default     = "cds-snc-service-health-alert"
}

variable "location" {
  description = "The Azure region where the resource group is located"
  type        = string
  default     = "canadacentral"
}


variable "alert_name" {
  description = "The name of the service health alert"
  type        = string
  default     = "Service Health Alert"
}

variable "alert_description" {
  description = "Description for the service health alert"
  type        = string
  default     = "Alert rule for Azure Service Health events"
}

variable "action_group_id" {
  description = "The ID of the existing action group to use for notifications"
  type        = string
}

variable "service_health_events" {
  description = "List of service health event types to monitor"
  type        = list(string)
  default     = ["Incident", "Informational", "Security"]
}

variable "service_health_locations" {
  description = "List of Azure regions to monitor for service health events"
  type        = list(string)
  default     = ["Canada Central", "Canada East", "Global"]
}

variable "service_health_services" {
  description = "List of Azure services to monitor. Empty list means all services"
  type        = list(string)
  default     = []
}

variable "enabled" {
  description = "Whether the alert rule is enabled"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default = {
    ClientOrganization = "cds-snc"
    CostCenter         = "sentinel"
    DataSensitivity    = "U"
    ProjectContact     = "Security@CDS"
    ProjectName        = "Sentinel"
  }
}
