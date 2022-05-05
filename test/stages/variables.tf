
variable "resource_group_name" {
  type        = string
  description = "Resource group to be created."
}

variable "region" {
  type        = string
  description = "Region/location to deploy into."
}

variable "subscription_id" {}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}