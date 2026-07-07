resource "azurerm_resource_group" "main" {
  name     = "rg-landing-zone-dev-westeurope"
  location = var.location
  tags     = var.tags
}

module "vnets" {
  source = "./modules/virtual-network"

  for_each = var.virtual_networks

  name                = each.value.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = each.value.address_space
  tags                = var.tags
}

module "subnets" {
  source = "./modules/subnet"

  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.vnets[each.value.virtual_network].name
  address_prefixes     = each.value.address_prefixes

}

module "network_security_groups" {
  source = "./modules/network-security-group"

  for_each = var.network_security_groups

  name                = each.value.name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "subnet_nsg_association" {
  source = "./modules/subnet-nsg-association"

  for_each = var.subnet_nsg_association

  subnet_id                 = module.subnets[each.value.subnet_key].id
  network_security_group_id = module.network_security_groups[each.value.nsg_key].id
}

module "vnet_peering" {
  source = "./modules/vnet-peering"

  for_each = var.vnet_peerings

  name                      = each.value.name
  resource_group_name       = azurerm_resource_group.main.name
  virtual_network_name      = module.vnets[each.value.virtual_network].name
  remote_virtual_network_id = module.vnets[each.value.remote_virtual_network].id

  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit        = each.value.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
}

module "log_analytics" {
  source = "./modules/log-analytics"

  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_workspace_retention_in_days
  tags                = var.tags
}

module "storage_account" {
  source = "./modules/storage-account"

  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  container_name           = var.storage_container_name
  tags                     = var.tags
}

module "policy_allowed_locations" {
  source = "./modules/policy-assignment"

  name                = "allowed-locations-dev"
  display_name        = "Allowed locations for dev landing zone"
  description         = "Restricts resource deployment to approved Azure regions."
  resource_group_id   = azurerm_resource_group.main.id
  policy_display_name = "Allowed locations"

  parameters = {
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  }
}

module "storage_account_diagnostic_settings" {
  source = "./modules/diagnostic-setting"

  name = "diag-storage-account"

  target_resource_id         = module.storage_account.id
  log_analytics_workspace_id = module.log_analytics.id
}
