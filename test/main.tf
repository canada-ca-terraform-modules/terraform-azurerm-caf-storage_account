terraform {
  required_version = ">= 0.12.1"
}
provider "azurerm" {
  version = ">= 1.32.0"
  features {}
}

module Project-sa {
  source            = "../."
  env               = var.env
  userDefinedString = "test"
  resource_group    = azurerm_resource_group.test-RG
  tags              = var.tags
}