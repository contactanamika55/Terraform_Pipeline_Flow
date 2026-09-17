data "azurerm_subnet" "appgw" {
  for_each = var.appgw

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}
resource "azurerm_public_ip" "appgw_pip" {
  for_each = var.ipvar

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# data "azurerm_public_ip" "appgw_pip" {
#   for_each = var.appgw

#   name                = "dev-appgw-pip"
#   resource_group_name = each.value.resource_group_name
# }
resource "azurerm_application_gateway" "appgw" {
  for_each = var.appgw

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = each.value.min_capacity
    max_capacity = each.value.max_capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.appgw[each.key].id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.appgw_pip[each.key].id
  }

  backend_address_pool {
    name         = "vm-backend-pool"
    ip_addresses = each.value.backend_ips
  }

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    priority                   = 100
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "vm-backend-pool"
    backend_http_settings_name = "http-setting"
  }


  tags = {
    Environment = each.value.environment
  }
}