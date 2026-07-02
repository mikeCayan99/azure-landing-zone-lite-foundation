variable "name" {
  description = "Name of the policy assignment"
  type        = string
}

variable "display_name" {
  description = "Display name of the policy assignment"
  type        = string
}

variable "description" {
  description = "Description of the policy assignment"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID where the policy will be assigned"
  type        = string
}

variable "policy_display_name" {
  description = "Display name of the built-in Azure Policy definition"
  type        = string
}

variable "parameters" {
  description = "Policy assignment parameters"
  type        = any
}