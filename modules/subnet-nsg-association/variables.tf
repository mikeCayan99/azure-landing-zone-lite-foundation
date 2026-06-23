variable "subnet_id" {
  description = "The ID of the subnet to associate with the NSG."
  type        = string
}

variable "network_security_group_id" {
  description = "The ID of the network security group to associate with the subnet."
  type        = string
}

