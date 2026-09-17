# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "RG_STATE_FILE"
    storage_account_name = "backendstg001"
    container_name       = "con005"
    key                  = "projectstatefilenew"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "e34ff9d4-b152-4505-9e32-981f05389fa8"
}

