resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.AKS
  name                = each.value.aks_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name           = each.value.default_node_pool
    vm_size        = each.value.vm_size
    node_count     = each.value.node_count
    vnet_subnet_id = data.azurerm_subnet.aksbnet[each.key].id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.100.0.0/16"
    dns_service_ip = "10.100.0.10"
  }

  tags = {
    environment = each.value.enviroment_name
  }

  node_provisioning_profile {
    mode = "Auto"
  }


}