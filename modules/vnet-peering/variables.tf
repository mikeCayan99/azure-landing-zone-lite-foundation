variable "name" {
  description = "Name of the VNet peering"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the local virtual network"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote virtual network"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow traffic between the peered virtual networks"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic from the remote virtual network"
  type        = bool
  default     = true
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit through the peering"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use remote gateways from the remote virtual network"
  type        = bool
  default     = false
}