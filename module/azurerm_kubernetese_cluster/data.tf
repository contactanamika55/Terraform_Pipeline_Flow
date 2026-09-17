# data "azurerm_application_gateway" "apgw1" {
#     for_each = var.AKS
#   name = "dev-nitor-appgw-01" 
#   resource_group_name = "dev-nitor-rg-002"
# }
data "azurerm_subnet" "aksbnet" {
  for_each = var.AKS

  name                 = each.value.subnetname
  virtual_network_name = each.value.vnetname
  resource_group_name  = each.value.resource_group_name
}