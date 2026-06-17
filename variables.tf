variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "virtual_networks" {
  description = "Virtual networks to create"
  type = map(object({
    name          = string
    address_space = list(string)
  }))

  default = {
    hub = {
      name          = "vnet-hub-dev-westeurope"
      address_space = ["10.0.0.0/16"]
    }

    spoke_workload = {
      name          = "vnet-spoke-workload-dev-westeurope"
      address_space = ["10.1.0.0/16"]
    }

    spoke_shared = {
      name          = "vnet-spoke-shared-dev-westeurope"
      address_space = ["10.2.0.0/16"]
    }
  }
}


variable "subnets" {
  description = "Subnets to create"
  type = map(object({
    name             = string
    virtual_network  = string
    address_prefixes = list(string)
  }))
}

