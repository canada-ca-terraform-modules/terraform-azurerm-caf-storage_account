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
  name                              = local.storage_account-name
  location                          = var.resource_group.location
  resource_group_name               = var.resource_group.name
  access_tier                       = var.access_tier
  account_tier                      = var.account_tier
  account_kind                      = var.account_kind
  account_replication_type          = var.account_replication_type
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  is_hns_enabled                    = var.is_hns_enabled
  min_tls_version                   = var.min_tls_version
  nfsv3_enabled                     = var.nfsv3_enabled
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  edge_zone                         = var.edge_zone
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  local_user_enabled                = var.local_user_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  table_encryption_key_type         = var.table_encryption_key_type
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  allowed_copy_scope                = var.allowed_copy_scope
  sftp_enabled                      = var.sftp_enabled
  dns_endpoint_type                 = var.dns_endpoint_type
  provisioned_billing_model_version = var.provisioned_billing_model_version
  tags                              = local.tags

  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      bypass                     = try(network_rules.value.bypass, null)
      ip_rules                   = try(network_rules.value.ip_rules, null)
      virtual_network_subnet_ids = try(network_rules.value.virtual_network_subnet_ids, null)

      dynamic "private_link_access" {
        for_each = try(network_rules.value.private_link_access, [])
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = try(private_link_access.value.endpoint_tenant_id, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []
    content {
      versioning_enabled            = try(blob_properties.value.versioning_enabled, null)
      change_feed_enabled           = try(blob_properties.value.change_feed_enabled, null)
      change_feed_retention_in_days = try(blob_properties.value.change_feed_retention_in_days, null)
      default_service_version       = try(blob_properties.value.default_service_version, null)
      last_access_time_enabled      = try(blob_properties.value.last_access_time_enabled, null)

      dynamic "cors_rule" {
        for_each = try(blob_properties.value.cors_rule, [])
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value.delete_retention_policy, null) != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days                     = try(delete_retention_policy.value.days, null)
          permanent_delete_enabled = try(delete_retention_policy.value.permanent_delete_enabled, null)
        }
      }

      dynamic "restore_policy" {
        for_each = try(blob_properties.value.restore_policy, null) != null ? [blob_properties.value.restore_policy] : []
        content {
          days = restore_policy.value.days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value.container_delete_retention_policy, null) != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = try(container_delete_retention_policy.value.days, null)
        }
      }
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id          = try(customer_managed_key.value.key_vault_key_id, null)
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      name          = custom_domain.value.name
      use_subdomain = try(custom_domain.value.use_subdomain, null)
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties != null ? [var.share_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = try(share_properties.value.cors_rule, [])
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "retention_policy" {
        for_each = try(share_properties.value.retention_policy, null) != null ? [share_properties.value.retention_policy] : []
        content {
          days = try(retention_policy.value.days, null)
        }
      }

      dynamic "smb" {
        for_each = try(share_properties.value.smb, null) != null ? [share_properties.value.smb] : []
        content {
          versions                        = try(smb.value.versions, null)
          authentication_types            = try(smb.value.authentication_types, null)
          kerberos_ticket_encryption_type = try(smb.value.kerberos_ticket_encryption_type, null)
          channel_encryption_type         = try(smb.value.channel_encryption_type, null)
          multichannel_enabled            = try(smb.value.multichannel_enabled, null)
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication != null ? [var.azure_files_authentication] : []
    content {
      directory_type                 = azure_files_authentication.value.directory_type
      default_share_level_permission = try(azure_files_authentication.value.default_share_level_permission, null)

      dynamic "active_directory" {
        for_each = try(azure_files_authentication.value.active_directory, null) != null ? [azure_files_authentication.value.active_directory] : []
        content {
          domain_name         = active_directory.value.domain_name
          domain_guid         = active_directory.value.domain_guid
          domain_sid          = try(active_directory.value.domain_sid, null)
          storage_sid         = try(active_directory.value.storage_sid, null)
          forest_name         = try(active_directory.value.forest_name, null)
          netbios_domain_name = try(active_directory.value.netbios_domain_name, null)
        }
      }
    }
  }

  dynamic "routing" {
    for_each = var.routing != null ? [var.routing] : []
    content {
      publish_internet_endpoints  = try(routing.value.publish_internet_endpoints, null)
      publish_microsoft_endpoints = try(routing.value.publish_microsoft_endpoints, null)
      choice                      = try(routing.value.choice, null)
    }
  }

  dynamic "sas_policy" {
    for_each = var.sas_policy != null ? [var.sas_policy] : []
    content {
      expiration_period = sas_policy.value.expiration_period
      expiration_action = try(sas_policy.value.expiration_action, null)
    }
  }

  dynamic "immutability_policy" {
    for_each = var.immutability_policy != null ? [var.immutability_policy] : []
    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      state                         = immutability_policy.value.state
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
    }
  }
}

# azurerm >= 4.x split static website configuration out of azurerm_storage_account
# into its own resource. Kept behind static_website_enabled for backward compat with
# existing tfvars; the storage account resource itself is unaffected (no replacement).
resource "azurerm_storage_account_static_website" "storage_account" {
  count              = var.static_website_enabled ? 1 : 0
  storage_account_id = azurerm_storage_account.storage_account.id
  index_document     = var.static_website_index_document
  error_404_document = try(var.static_website_error_404_document, null)
}
