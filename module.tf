locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags                                                 = merge(var.tags, local.module_tag)
  unique_8                                             = substr(sha1(var.resource_group.id), 0, 8)
  storage_account-regex                                = "/[^0-9a-z]/" # Anti-pattern to match all characters not in: 0-9 a-z
  env-regex_compliant_4                                = replace(lower(substr(var.env, 0, 4)), local.storage_account-regex, "")
  storage_account-userDefinedString-regex_compliant_16 = replace(lower(substr(var.userDefinedString, 0, 16)), local.storage_account-regex, "")
  storage_account-name                                 = substr("${local.env-regex_compliant_4}${local.storage_account-userDefinedString-regex_compliant_16}${local.unique_8}", 0, 24)
}

resource "azurerm_storage_account" "storage_account" {
  name                            = local.storage_account-name
  location                        = var.resource_group.location
  resource_group_name             = var.resource_group.name
  account_tier                    = var.account_tier
  account_kind                    = var.account_kind
  account_replication_type        = var.account_replication_type
  is_hns_enabled                  = var.is_hns_enabled
  min_tls_version                 = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  enable_https_traffic_only       = var.enable_https_traffic_only
  tags                            = var.tags
}
