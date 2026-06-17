output "resource_group_name" {
  value = azurerm_resource_group.rg-group.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg-group.location
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