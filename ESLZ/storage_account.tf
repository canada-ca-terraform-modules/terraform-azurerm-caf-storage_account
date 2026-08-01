# ESLZ/storage_account.tf
# Declares the variables consumed by the module block so L2 callers can wire
# their own var.* values in, and the module block itself.

terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}

variable "storage_account" {
  description = "Map of Storage Account configuration objects"
  type        = any
  default     = {}
}

variable "resource_groups" {
  description = "Map of resource group objects"
  type        = any
  default     = {}
}

variable "env" {
  description = "(Required) env value"
  type        = string
}

module "storage_account" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-storage_account?ref=v4.0.0"
  for_each = var.storage_account

  env               = var.env
  userDefinedString = each.key
  tags              = try(each.value.tags, {})
  resource_group    = var.resource_groups[each.value.resource_group]

  account_tier                    = try(each.value.account_tier, "Standard")
  account_kind                    = try(each.value.account_kind, "StorageV2")
  account_replication_type        = try(each.value.account_replication_type, "GRS")
  is_hns_enabled                  = try(each.value.is_hns_enabled, false)
  min_tls_version                 = try(each.value.min_tls_version, "TLS1_2")
  allow_nested_items_to_be_public = try(each.value.allow_nested_items_to_be_public, false)
  https_traffic_only_enabled      = try(each.value.https_traffic_only_enabled, true)
  public_network_access_enabled   = try(each.value.public_network_access_enabled, true)
  default_to_oauth_authentication = try(each.value.default_to_oauth_authentication, false)
  access_tier                     = try(each.value.access_tier, "Hot")
  shared_access_key_enabled       = try(each.value.shared_access_key_enabled, true)
  nfsv3_enabled                   = try(each.value.nfsv3_enabled, false)

  static_website_enabled            = try(each.value.static_website_enabled, false)
  static_website_index_document     = try(each.value.static_website_index_document, "index.html")
  static_website_error_404_document = try(each.value.static_website_error_404_document, null)

  edge_zone                         = try(each.value.edge_zone, null)
  cross_tenant_replication_enabled  = try(each.value.cross_tenant_replication_enabled, null)
  large_file_share_enabled          = try(each.value.large_file_share_enabled, null)
  local_user_enabled                = try(each.value.local_user_enabled, null)
  queue_encryption_key_type         = try(each.value.queue_encryption_key_type, null)
  table_encryption_key_type         = try(each.value.table_encryption_key_type, null)
  infrastructure_encryption_enabled = try(each.value.infrastructure_encryption_enabled, null)
  allowed_copy_scope                = try(each.value.allowed_copy_scope, null)
  sftp_enabled                      = try(each.value.sftp_enabled, null)
  dns_endpoint_type                 = try(each.value.dns_endpoint_type, null)
  provisioned_billing_model_version = try(each.value.provisioned_billing_model_version, null)

  network_rules              = try(each.value.network_rules, null)
  identity                   = try(each.value.identity, null)
  blob_properties            = try(each.value.blob_properties, null)
  customer_managed_key       = try(each.value.customer_managed_key, null)
  custom_domain              = try(each.value.custom_domain, null)
  share_properties           = try(each.value.share_properties, null)
  azure_files_authentication = try(each.value.azure_files_authentication, null)
  routing                    = try(each.value.routing, null)
  sas_policy                 = try(each.value.sas_policy, null)
  immutability_policy        = try(each.value.immutability_policy, null)
}
