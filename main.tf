resource "azurerm_resource_group" "example" {
  name     = "rg-landing-zone-dev-westeurope"
  location = "West Europe"


  tags = {
    environment = "dev"
    project     = "azure-landing-zone-foundation"
    managed_by  = "terraform"
  }

}