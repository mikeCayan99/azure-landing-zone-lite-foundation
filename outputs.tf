output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "resource_group_location" {
  value = azurerm_resource_group.main.location
}

output "subnet_names" {
  value = {
    for key, subnet in module.subnets : key => subnet.name
  }
}

output "subnet_ids" {
  value = {
    for key, subnet in module.subnets : key => subnet.id
  }
}

output "virtual_network_names" {
  value = {
    for key, vnet in module.vnets : key => vnet.name
  }
}