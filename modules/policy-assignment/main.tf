data "azurerm_policy_definition" "policy" {
  display_name = var.policy_display_name
}

resource "azurerm_resource_group_policy_assignment" "assignment" {
  name                 = var.name
  resource_group_id    = var.resource_group_id
  policy_definition_id = data.azurerm_policy_definition.policy.id
  display_name         = var.display_name
  description          = var.description

  parameters = jsonencode(var.parameters)
}