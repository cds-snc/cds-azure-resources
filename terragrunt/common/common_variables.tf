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

variable "security_email" {
  description = "The email address for the security resolver group"
  type        = string
}

variable "sre_email" {
  description = "The email address for the SRE resolver group"
  type        = string
}
