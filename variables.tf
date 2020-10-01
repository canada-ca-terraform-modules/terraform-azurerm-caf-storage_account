variable "tags" {
  description = "(Required) tagging for the log analytics workspace"
}

variable "resource_group" {
  description = "(Required) Resource group object for the storage_account to be created"
}

variable "env" {
  description = "(Required) env value"
  type        = string
  default     = ""
}

variable "userDefinedString" {
  description = "(Required) userDefinedString value"
  type        = string
  default     = ""
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_replication_type" {
  type    = string
  default = "GRS"
}

variable "is_hns_enabled" {
  type = bool
  default = false
}

variable "min_tls_version" {
  type = string
  default = "TLS1_2"
}

variable "allow_blob_public_access" {
  type = bool
  default = false
}