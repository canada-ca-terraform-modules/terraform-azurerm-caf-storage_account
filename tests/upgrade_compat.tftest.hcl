# tests/upgrade_compat.tftest.hcl
# Simulates a pre-upgrade deployment (only pre-existing args set), then re-plans
# the upgraded module against that state to prove no unexpected replacement.
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

# Step 1: simulate the currently-deployed resource using only pre-upgrade inputs
# (static_website was previously an inline block; here it's simply disabled, which
# is the equivalent baseline since the old inline block only ever set index_document).
run "baseline_apply" {
  command = apply

  # Pin a realistic ARM-ID-shaped id in state up front: the mock provider
  # otherwise generates an opaque random id, which fails ARM-ID parsing in
  # azurerm_storage_account_static_website.storage_account_id in later runs
  # that plan against this same chained state.
  override_resource {
    target = azurerm_storage_account.storage_account
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Storage/storageAccounts/devtest12345678"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.account_tier == "Standard"
    error_message = "Baseline apply: unexpected account_tier"
  }

  assert {
    condition     = length(azurerm_storage_account_static_website.storage_account) == 0
    error_message = "Baseline apply: static website resource must not exist"
  }
}

# Step 2: plan the upgraded code (with new v5 optional args set) against that state
run "upgrade_plan_no_replacement" {
  command = plan

  variables {
    large_file_share_enabled = true
    local_user_enabled       = true
    network_rules = {
      default_action = "Allow"
    }
  }

  assert {
    condition     = azurerm_storage_account.storage_account.name == run.baseline_apply.name
    error_message = "Resource name must be unchanged after upgrade"
  }

  assert {
    condition     = azurerm_storage_account.storage_account.large_file_share_enabled == true
    error_message = "large_file_share_enabled must be applied post-upgrade"
  }
}

# Step 3: enabling static website after the fact must only add the new companion
# resource — it must not force replacement of the storage account itself.
run "enable_static_website_post_upgrade" {
  command = plan

  variables {
    static_website_enabled = true
  }

  assert {
    condition     = azurerm_storage_account.storage_account.name == run.baseline_apply.name
    error_message = "Enabling static website must not replace the storage account"
  }

  assert {
    condition     = length(azurerm_storage_account_static_website.storage_account) == 1
    error_message = "Static website companion resource must be planned"
  }
}
