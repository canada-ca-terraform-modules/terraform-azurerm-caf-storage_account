data "azurerm_client_config" "current" {}

terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = ">= 2.34.0"
  }
}

locals {
}
