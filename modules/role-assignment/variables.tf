variable "scope" {
  description = "Scope where the role assignment is applied"
  type        = string
}

variable "role_definition_name" {
  description = "Azure RBAC role name"
  type        = string
}

variable "principal_id" {
  description = "Object ID of the principal receiving the role"
  type        = string
}