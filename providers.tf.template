terraform {
  required_version = ">= 1.3.9"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "TFSTATE_STORAGE_RG"
    storage_account_name = "TFSTATE_STORAGE_ACCOUNT"
    container_name       = "TFSTATE_STORAGE_CONTAINER"
    key                  = "TFSTATE_FILE"
  }
}

provider "azurerm" {
  features {}
}
