# config/storage_account.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# Exercises the module's static_website_enabled input (the headline delta
# between azurerm v4 and v5+: the static_website block was extracted out of
# azurerm_storage_account into the separate
# azurerm_storage_account_static_website resource) - same fixture shape
# already validated in this module's L2 upgrade-probe harness.
#
# Maintained by whoever adds a new optional input to the module: update this
# file in the same PR if you want live coverage of it, same discipline as
# updating tests/storage_account.tftest.hcl.

env = "livetest"

account_tier                    = "Standard"
account_kind                    = "StorageV2"
account_replication_type        = "GRS"
is_hns_enabled                  = false
min_tls_version                 = "TLS1_2"
allow_nested_items_to_be_public = false
https_traffic_only_enabled      = true
public_network_access_enabled   = true
default_to_oauth_authentication = false
access_tier                     = "Hot"
shared_access_key_enabled       = true
nfsv3_enabled                   = false
static_website_enabled          = true
