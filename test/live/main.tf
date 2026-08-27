terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }

  # Empty on purpose: the state file path is supplied at `terraform init`
  # time via `-backend-config="path=..."` (partial configuration), so the
  # target-branch checkout and the PR-branch checkout can point at the same
  # external state file without either owning its own local state.
  backend "local" {}
}

provider "azurerm" {
  storage_use_azuread             = true
  resource_provider_registrations = "legacy"
  features {
    resource_group {
      # This harness's resource group is fully self-owned by Terraform - no
      # risk of destroying anything not created by this run.
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "storage_account" {
  # PR code and baseline code are two on-disk checkouts of this same repo,
  # not two resolved git refs - no pinned ?ref, no version toggle here.
  source = "../../"

  env               = var.env
  userDefinedString = "livetest"
  resource_group    = local.resource_group # from test_dependencies.tf
  tags              = var.tags

  account_tier                    = var.account_tier
  account_kind                    = var.account_kind
  account_replication_type        = var.account_replication_type
  is_hns_enabled                  = var.is_hns_enabled
  min_tls_version                 = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  https_traffic_only_enabled      = var.https_traffic_only_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication
  access_tier                     = var.access_tier
  shared_access_key_enabled       = var.shared_access_key_enabled
  nfsv3_enabled                   = var.nfsv3_enabled
  static_website_enabled          = var.static_website_enabled
}
