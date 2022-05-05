
variable "resource_group_name" {
  type        = string
  description = "Resource group to be created."
}

variable "region" {
  type        = string
  description = "Region/location to deploy into."
}

variable "subscription_id" {
  type        = string
  description = "Subscription Id"
}

variable "client_id" {
  type        = string
  description = "Client Id"
}

variable "client_secret" {
  type        = string
  description = "Client secret"
}

variable "tenant_id" {
  type        = string
  description = "Tenant Id"
}