variable "tags" {
  description = "Tags to be applied to the Storage Account to be created"
  type        = map(string)
}

variable "resource_group" {
  description = "Resource group object of the Storage Account to be created"
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
  type        = string
  default     = "Standard"
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
  type        = string
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
  default     = "GRS"
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  type        = string
  default     = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type        = bool
  default     = false
}

variable "https_traffic_only_enabled" {
  description = "(Optional) Enable default outbound access to the internet for the subnet. Defaults to true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false"
  type        = bool
  default     = false
}

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  type        = string
  default     = "Hot"
}

variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true."
  type        = bool
  default     = true
}

variable "nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = false
}

variable "static_website_enabled" {
  description = "(Optional) Enable static website hosting for this Storage Account. Provisions a companion azurerm_storage_account_static_website resource (azurerm >= 4.x split this out of azurerm_storage_account). Defaults to false."
  type        = bool
  default     = false
}

variable "static_website_index_document" {
  description = "(Optional) The webpage that Azure Storage serves for requests to the root of the static website or any subfolder. Only used when static_website_enabled is true. Defaults to index.html."
  type        = string
  default     = "index.html"
}

variable "static_website_error_404_document" {
  description = "(Optional) The absolute path to a custom webpage used when a request is made which does not correspond to an existing file. Only used when static_website_enabled is true."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "cross_tenant_replication_enabled" {
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to false."
  type        = bool
  default     = null
}

variable "large_file_share_enabled" {
  description = "(Optional) Are Large File Shares Enabled? Defaults to false."
  type        = bool
  default     = null
}

variable "local_user_enabled" {
  description = "(Optional) Is Local User Enabled? Defaults to true."
  type        = bool
  default     = null
}

variable "queue_encryption_key_type" {
  description = "(Optional) The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = null
}

variable "table_encryption_key_type" {
  description = "(Optional) The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = null
}

variable "infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = null
}

variable "allowed_copy_scope" {
  description = "(Optional) The permitted scope for copy operations between storage accounts. Possible values are AAD, PrivateLink and All."
  type        = string
  default     = null
}

variable "sftp_enabled" {
  description = "(Optional) Boolean, enable SFTP for the storage account. Requires is_hns_enabled to be true. Defaults to false."
  type        = bool
  default     = null
}

variable "dns_endpoint_type" {
  description = "(Optional) Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "provisioned_billing_model_version" {
  description = "(Optional) Specifies the version of the provisioned billing model (e.g. when account_kind = FileStorage for Storage File). Possible value is V2. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "network_rules" {
  description = "(Optional) A network_rules block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#network_rules"
  type        = any
  default     = null
}

variable "identity" {
  description = "(Optional) An identity block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#identity"
  type        = any
  default     = null
}

variable "blob_properties" {
  description = "(Optional) A blob_properties block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#blob_properties"
  type        = any
  default     = null
}

variable "customer_managed_key" {
  description = "(Optional) A customer_managed_key block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#customer_managed_key"
  type        = any
  default     = null
}

variable "custom_domain" {
  description = "(Optional) A custom_domain block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#custom_domain"
  type        = any
  default     = null
}

variable "share_properties" {
  description = "(Optional) A share_properties block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#share_properties"
  type        = any
  default     = null
}

variable "azure_files_authentication" {
  description = "(Optional) An azure_files_authentication block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#azure_files_authentication"
  type        = any
  default     = null
}

variable "routing" {
  description = "(Optional) A routing block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#routing"
  type        = any
  default     = null
}

variable "sas_policy" {
  description = "(Optional) A sas_policy block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#sas_policy"
  type        = any
  default     = null
}

variable "immutability_policy" {
  description = "(Optional) An immutability_policy block. Changing this forces a new resource to be created. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#immutability_policy"
  type        = any
  default     = null
}
