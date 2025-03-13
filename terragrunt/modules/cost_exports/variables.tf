variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Cost Management Export. Changing this forces a new resource to be created."
}


variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
  default     = "canadacentral"
}


variable "billing_account_id" {
  type        = string
  description = "(Required) The id of the billing account on which to create an export. Changing this forces a new resource to be created."
}

variable "recurrence_type" {
  type        = string
  description = "(Required) How often the requested information will be exported. Valid values include Annually, Daily, Monthly, Weekly."
  default     = "Daily"
}

variable "recurring_period_start_date" {
  type        = string
  description = "(Required) The date the export will start capturing information."
}

variable "recurring_period_end_date" {
  type        = string
  description = "(Required) The date the export will stop capturing information."
}

variable "time_frame" {
  type        = string
  description = "(Required) The time frame for pulling data for the query. If custom, then a specific time period must be provided. Possible values include: WeekToDate, MonthToDate, BillingMonthToDate, TheLast7Days, TheLastMonth, TheLastBillingMonth, Custom."
  default     = "MonthToDate"
}

variable "type" {
  type        = string
  description = "(Required) The type of the query. Possible values are ActualCost, AmortizedCost and Usage"
  default     = "ActualCost"
}

variable "root_folder_path" {
  type        = string
  description = "The root folder path where the export data will be written in the storage container."
  default     = "cost-exports"
}
