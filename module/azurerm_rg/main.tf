resource "azurerm_resource_group" "rg1" {
  for_each = var.child_rg
  name     = each.value.rg_name
  location = each.value.location
}