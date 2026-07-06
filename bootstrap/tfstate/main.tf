resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "dev"
    purpose     = "terraform-state"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version            = "TLS1_2"
  https_traffic_only_enabled = true

  tags = {
    environment = "dev"
    purpose     = "terraform-state"
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}