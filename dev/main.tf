module "create_rg" {
  source   = "../module/azurerm_rg"
  child_rg = var.root_rg
}

module "create_stg" {
  depends_on      = [module.create_rg]
  source          = "../module/azurerm_storage_account"
  storage_account = var.root_stg
}

module "create_network" {
  depends_on      = [module.create_rg]
  source          = "../module/azurerm_networking"
  virtual_network = var.root_network

}

module "create_aks" {
  depends_on = [module.create_network]
  source     = "../module/azurerm_kubernetese_cluster"
  AKS        = var.root_AKS
}


module "create_acr" {
  depends_on = [module.create_rg]
  source     = "../module/Azurerm_ACR"
  ACR        = var.root_ACR

}

# module "create_appgw_public_ip" {
#   depends_on = [var.root_network]
#   source     = "../module/Azurerm_Public_ip"
#   appgw      = var.root_publicip

# }

module "create_appgw" {
  source     = "../module/azurerm_applicationgateway"
  appgw      = var.root_APPGW
  ipvar      = var.root_publicip
  depends_on = [module.create_network]
}