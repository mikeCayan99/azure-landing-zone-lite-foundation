variable "name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "Azure region for the Log Analytics Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
}

variable "retention_in_days" {
  description = "Data retention in days"
  type        = number
}

variable "tags" {
  description = "Tags for the Log Analytics Workspace"
  type        = map(string)
}