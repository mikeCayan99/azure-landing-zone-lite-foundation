resource "azurerm_resource_group" "main" {
  name     = "rg-landing-zone-dev-westeurope"
  location = "West Europe"


  tags = {
    environment = "dev"
    project     = "azure-landing-zone-foundation"
    managed_by  = "terraform"
  }

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

  subnet_id                 = module.subnets[each.value.subnet].id
  network_security_group_id = module.network_security_groups[each.value.network_security_group].id
}

