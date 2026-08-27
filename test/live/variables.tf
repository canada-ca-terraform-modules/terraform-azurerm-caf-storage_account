variable "env" {
  description = "Environment prefix used in the generated Storage Account name"
  type        = string
  default     = "livetest"
}

variable "location" {
  description = "Location for the throwaway live-test resource group"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Tags applied to the Storage Account created by this harness"
  type        = map(string)
  default = {
    purpose = "module-live-test"
  }
}

variable "pr_number" {
  description = <<-EOT
    Suffix applied to test_dependencies.tf resource names so concurrent PRs
    against this module never collide on the same sandbox subscription. CI
    sources this from `TF_VAR_pr_number` (`github.event.number`); manual runs
    can leave the default or pass their own value.
  EOT
  type        = string
  default     = "manual"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account, passed through to the module under test"
  type        = string
  default     = "Standard"
}

variable "account_kind" {
  description = "Defines the Kind of account, passed through to the module under test"
  type        = string
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account, passed through to the module under test"
  type        = string
  default     = "GRS"
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled, passed through to the module under test"
  type        = bool
  default     = false
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account, passed through to the module under test"
  type        = string
  default     = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public, passed through to the module under test"
  type        = bool
  default     = false
}

variable "https_traffic_only_enabled" {
  description = "Boolean flag which forces HTTPS if enabled, passed through to the module under test"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled, passed through to the module under test"
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account, passed through to the module under test"
  type        = bool
  default     = false
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts, passed through to the module under test"
  type        = string
  default     = "Hot"
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key, passed through to the module under test"
  type        = bool
  default     = true
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled, passed through to the module under test"
  type        = bool
  default     = false
}

variable "static_website_enabled" {
  description = "Enable static website hosting for this Storage Account, passed through to the module under test"
  type        = bool
  default     = false
}
