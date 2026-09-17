variable "root_rg" {
  type = map(object({
    rg_name  = string
    location = string
  }))
}

variable "root_stg" {
  type = map(object({
    storage_account_name     = string
    resource_group           = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))

}

variable "root_network" {
  type = map(object({
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string

    subnet = map(object({
      name             = string
      address_prefixes = list(string)
    }))

  }))

}

variable "root_database" {
  description = "Azure SQL Database configuration."

  type = map(object({
    database_name = string
    sku_name      = string
  }))
}
# variable "sql_server_ids" {
#   description = "Map of Azure SQL Server IDs received from the SQL Server module."
#   type        = map(string)
# }
variable "root_server" {
  description = "Azure SQL Server configuration."

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    admin_login         = string
    admin_password      = string
  }))

  sensitive = true
}

variable "root_AKS" {
  description = "Azure Kubernetes Service cluster configuration."

  type = map(object({
    aks_name            = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    default_node_pool   = string
    vm_size             = string
    node_count          = number
    enviroment_name     = string
    vnetname            = string
    subnetname          = string
  }))
}

variable "root_ACR" {
  type = map(object({
    name = string

    location = string

    resource_group_name = string
    sku                 = string
  }))
}


variable "root_APPGW" {
  description = "Application Gateway configuration."

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    vnet_name      = string
    subnet_name    = string
    public_ip_name = string
    backend_ips    = list(string)

    min_capacity = number
    max_capacity = number
    environment  = string
  }))
}


variable "root_publicip" {
  description = "Application Gateway Public IP configuration."

  type = map(object({
    public_ip_name      = string
    location            = string
    resource_group_name = string
  }))
}