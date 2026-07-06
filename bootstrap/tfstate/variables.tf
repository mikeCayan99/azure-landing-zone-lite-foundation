variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group for Terraform state"
  type        = string
  default     = "rg-tfstate-dev-westeurope"
}

variable "storage_account_name" {
  description = "Globally unique storage account name for Terraform state"
  type        = string
}

variable "container_name" {
  description = "Blob container name for Terraform state"
  type        = string
  default     = "tfstate"
}