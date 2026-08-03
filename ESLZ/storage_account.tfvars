# ESLZ/storage_account.tfvars
# Rules: existing entries unchanged; new args go below, commented out with explanation

storage_account = {
  # --- EXISTING ENTRY (unchanged) ---
  myapp = {
    resource_group = "rg-example"
    tags           = { environment = "dev" }
  }

  # --- NEW ARGUMENT EXAMPLES (commented out) ---
  # myapp-with-new-features = {
  #   resource_group = "rg-example"
  #   tags           = { environment = "dev" }
  #
  #   # Static website hosting (azurerm >= 4.x split this into its own resource)
  #   static_website_enabled            = true
  #   static_website_index_document     = "index.html"
  #   static_website_error_404_document = "404.html"
  #
  #   # New in azurerm v5: additional top-level arguments
  #   large_file_share_enabled = true
  #   local_user_enabled       = false
  #   sftp_enabled             = true
  #   dns_endpoint_type        = "Standard"
  #
  #   # New: network_rules block
  #   network_rules = {
  #     default_action             = "Deny"
  #     ip_rules                   = ["100.0.0.1"]
  #     virtual_network_subnet_ids = []
  #   }
  #
  #   # New: managed identity
  #   identity = {
  #     type = "SystemAssigned"
  #   }
  #
  #   # New: blob_properties block (versioning + soft delete)
  #   blob_properties = {
  #     versioning_enabled = true
  #     delete_retention_policy = {
  #       days = 30
  #     }
  #   }
  # }
}
