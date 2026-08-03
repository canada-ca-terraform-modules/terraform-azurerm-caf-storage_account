# tests/storage_account.tftest.hcl
mock_provider "azurerm" {}

variables {
  env               = "Dev"
  userDefinedString = "test"
  tags              = { environment = "test" }
  resource_group = {
    name     = "rg-test"
    location = "canadacentral"
    id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test"
  }
}

run "naming_convention" {
  command = plan

  assert {
    condition     = length(azurerm_storage_account.storage_account.name) <= 24
    error_message = "Storage account name must not exceed 24 characters"
  }

  assert {
    condition     = can(regex("^[0-9a-z]+$", azurerm_storage_account.storage_account.name))
    error_message = "Storage account name must be lowercase alphanumeric only"
  }
}

run "default_values" {
  command = plan

  assert {
    condition     = azurerm_storage_account.storage_account.account_tier == "Standard"
    error_message = "Default account_tier must be Standard"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.account_kind == "StorageV2"
    error_message = "Default account_kind must be StorageV2"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.account_replication_type == "GRS"
    error_message = "Default account_replication_type must be GRS"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.min_tls_version == "TLS1_2"
    error_message = "Default min_tls_version must be TLS1_2"
  }

  assert {
    condition     = length(azurerm_storage_account_static_website.storage_account) == 0
    error_message = "Static website resource must not be created by default"
  }
}

run "tags_are_merged_with_module_tag" {
  command = plan

  assert {
    condition     = azurerm_storage_account.storage_account.tags["environment"] == "test"
    error_message = "Caller-supplied tags must be preserved"
  }

  assert {
    condition     = contains(keys(azurerm_storage_account.storage_account.tags), "module")
    error_message = "module tag must be merged into tags"
  }
}

run "static_website_enabled_default_index_document" {
  command = plan
  variables {
    static_website_enabled = true
  }

  assert {
    condition     = length(azurerm_storage_account_static_website.storage_account) == 1
    error_message = "Static website resource must be created when enabled"
  }

  assert {
    condition     = azurerm_storage_account_static_website.storage_account[0].index_document == "index.html"
    error_message = "Default index_document must be index.html"
  }
}

run "static_website_custom_documents" {
  command = plan
  variables {
    static_website_enabled            = true
    static_website_index_document     = "home.html"
    static_website_error_404_document = "notfound.html"
  }

  assert {
    condition     = azurerm_storage_account_static_website.storage_account[0].index_document == "home.html"
    error_message = "Custom index_document override not applied"
  }

  assert {
    condition     = azurerm_storage_account_static_website.storage_account[0].error_404_document == "notfound.html"
    error_message = "Custom error_404_document override not applied"
  }
}

run "network_rules" {
  command = plan
  variables {
    network_rules = {
      default_action             = "Deny"
      ip_rules                   = ["100.0.0.1"]
      virtual_network_subnet_ids = []
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.network_rules[0].default_action == "Deny"
    error_message = "network_rules.default_action must be applied"
  }
}

run "identity" {
  command = plan
  variables {
    identity = {
      type = "SystemAssigned"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.identity[0].type == "SystemAssigned"
    error_message = "identity.type must be applied"
  }
}

run "blob_properties_delete_retention_policy" {
  command = plan
  variables {
    blob_properties = {
      versioning_enabled = true
      delete_retention_policy = {
        days = 30
      }
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.blob_properties[0].versioning_enabled == true
    error_message = "blob_properties.versioning_enabled must be applied"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.blob_properties[0].delete_retention_policy[0].days == 30
    error_message = "blob_properties.delete_retention_policy.days must be applied"
  }
}

run "no_optional_blocks_by_default" {
  command = plan

  assert {
    condition     = length(azurerm_storage_account.storage_account.network_rules) == 0
    error_message = "network_rules must be absent when not configured"
  }

  assert {
    condition     = length(azurerm_storage_account.storage_account.identity) == 0
    error_message = "identity must be absent when not configured"
  }

  assert {
    condition     = length(azurerm_storage_account.storage_account.blob_properties) == 0
    error_message = "blob_properties must be absent when not configured"
  }
}

run "customer_managed_key" {
  command = plan
  variables {
    customer_managed_key = {
      key_vault_key_id          = "https://kv-test.vault.azure.net/keys/example/abc123"
      user_assigned_identity_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-test"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.customer_managed_key[0].user_assigned_identity_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-test"
    error_message = "customer_managed_key.user_assigned_identity_id must be applied"
  }
}

run "custom_domain" {
  command = plan
  variables {
    custom_domain = {
      name          = "www.example.com"
      use_subdomain = true
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.custom_domain[0].name == "www.example.com"
    error_message = "custom_domain.name must be applied"
  }
}

run "share_properties" {
  command = plan
  variables {
    share_properties = {
      retention_policy = {
        days = 14
      }
      smb = {
        versions = ["SMB3.1.1"]
      }
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.share_properties[0].retention_policy[0].days == 14
    error_message = "share_properties.retention_policy.days must be applied"
  }
}

run "azure_files_authentication" {
  command = plan
  variables {
    azure_files_authentication = {
      directory_type = "AADDS"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.azure_files_authentication[0].directory_type == "AADDS"
    error_message = "azure_files_authentication.directory_type must be applied"
  }
}

run "routing" {
  command = plan
  variables {
    routing = {
      choice = "InternetRouting"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.routing[0].choice == "InternetRouting"
    error_message = "routing.choice must be applied"
  }
}

run "sas_policy" {
  command = plan
  variables {
    sas_policy = {
      expiration_period = "01.00:00:00"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.sas_policy[0].expiration_period == "01.00:00:00"
    error_message = "sas_policy.expiration_period must be applied"
  }
}

run "immutability_policy" {
  command = plan
  variables {
    immutability_policy = {
      allow_protected_append_writes = true
      state                         = "Unlocked"
      period_since_creation_in_days = 30
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.immutability_policy[0].state == "Unlocked"
    error_message = "immutability_policy.state must be applied"
  }
}

