output "id" {
  value = azurerm_storage_account.storage_account.id
}

output "name" {
  value = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "container_name" {
  value = azurerm_storage_container.container.name
}

