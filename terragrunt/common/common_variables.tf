variable "root_id" {
  type    = string
  default = "cds-snc"
}

variable "root_name" {
  type    = string
  default = "CDS-SNC"
}

variable "region" {
  type    = string
  default = "canadacentral"
}

variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
  default     = "canadacentral"
}

variable "secondary_location" {
  type        = string
  description = "Sets the location for \"secondary\" resources to be created in."
  default     = "canadaeast"
}

variable "SECURITY_EMAIL" {
  description = "The email address for the security resolver group"
  type        = string
}

variable "SRE_EMAIL" {
  description = "The email address for the SRE resolver group"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID to use for the provider"
  type        = string
}