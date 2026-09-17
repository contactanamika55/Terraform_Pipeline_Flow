root_rg = {
  "RG1" = {
    rg_name  = "FITCART_RG"
    location = "Central US"
  }

}

root_stg = {

  storage1 = {
    storage_account_name     = "devstorageanamikaraj2026"
    resource_group           = "FITCART_RG"
    location                 = "Central US"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

root_network = {
  network1 = {
    name                = "dev-vnet-001"
    address_space       = ["10.0.0.0/16"]
    location            = "Central US"
    resource_group_name = "FITCART_RG"

    subnet = {
      subnet1 = {
        name             = "dev-subnet-001"
        address_prefixes = ["10.0.1.0/24"]
      }

      subnet2 = {
        name             = "appgw-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }

    }
  }
}

root_server = {
  sqlserver1 = {
    name                = "dev-server-001"
    location            = "East US 2"
    resource_group_name = "Central US"
    admin_login         = "sqladmin"
    admin_password      = "@1234devenv"

  }
}

root_database = {
  database1 = {
    database_name = "dev-db-001"
    sku_name      = "S0"
  }
}

root_AKS = {
  aks1 = {
    aks_name            = "dev-cluster-01"
    location            = "Central US"
    resource_group_name = "FITCART_RG"
    dns_prefix          = "devaks"
    default_node_pool   = "system"
    vm_size             = "standard_d2als_v7"
    node_count          = "1"
    enviroment_name     = "Dev"
    vnetname            = "dev-vnet-001"
    subnetname          = "dev-subnet-001"

  }
}

root_ACR = {
  acr1 = {
    name                = "devacr090"
    location            = "Central US"
    resource_group_name = "FITCART_RG"
    sku                 = "Standard"
  }

}


root_APPGW = {
  appgw1 = {
    name                = "dev-appgw-001"
    location            = "Central US"
    resource_group_name = "FITCART_RG"

    vnet_name      = "dev-vnet-001"
    subnet_name    = "appgw-subnet"
    public_ip_name = "dev-appgw-pip"
    backend_ips    = ["10.0.1.4"]

    min_capacity = 1
    max_capacity = 3
    environment  = "Dev"
  }
}

root_publicip = {
  appgw1 = {
    public_ip_name      = "dev-appgw-pip"
    location            = "Central US"
    resource_group_name = "FITCART_RG"
  }
}