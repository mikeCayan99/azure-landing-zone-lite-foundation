resource "azurerm_resource_group" "example" {
  name     = "Name of the RG"
  location = "West Europe"


  tags = {
    environment = "dev"
    project     = "azure-landing-zone-foundation"
    managed_by  = "terraform"
  }

}