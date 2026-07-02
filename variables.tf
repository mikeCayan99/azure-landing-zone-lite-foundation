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

variable "tags" {
  description = "Default tags applied to all resources"
  type        = map(string)

  default = {
    environment = "dev"
    project     = "azure-landing-zone-foundation"
    managed_by  = "terraform"
  }
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

variable "network_security_groups" {
  description = "Network Security Groups to create"
  type = map(object({
    name = string
  }))
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "subnet_nsg_association" {
  description = "Subnet to NSG associations"

  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "vnet_peerings" {
  description = "VNet peerings to create"
  type = map(object({
    name                         = string
    virtual_network              = string
    remote_virtual_network       = string
    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  }))
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_workspace_retention_in_days" {
  description = "Retention period in days for Log Analytics data"
  type        = number
  default     = 30
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "storage_container_name" {
  description = "Storage container name"
  type        = string
  default     = "tfstate"
}


variable "allowed_locations" {
  description = "List of allowed Azure regions"
  type        = list(string)
  default     = ["westeurope"]
}








