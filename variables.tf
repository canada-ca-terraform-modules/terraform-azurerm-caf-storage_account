variable "tags" {
  description = "Tags to be applied to the AKV to be created"
  type        = map(string)
}

variable "resource_group" {
  description = "Resource group object of the AKV to be created"
  type        = any
}

variable "env" {
  description = "(Required) env value"
  type        = string
}

variable "userDefinedString" {
  description = "UserDefinedString part of the name of the resource"
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type    = string
  default = "Standard"
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
  type    = string
  default = "StorageV2"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type    = string
  default = "GRS"
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created."
  type    = bool
  default = false
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  type    = string
  default = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type    = bool
  default = false
}