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

output "vnet_peering_names" {
  value = {
    for key, peering in module.vnet_peering : key => peering.name
  }
}

output "vnet_peering_ids" {
  value = {
    for key, peering in module.vnet_peering : key => peering.id
  }
}

output "id" {
  value = azurerm_log_analytics_workspace.workspace.id
}

output "name" {
  value = azurerm_log_analytics_workspace.workspace.name
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.workspace.workspace_id
}
