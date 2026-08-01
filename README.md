# Deploys an Azure Storage Account

Creates an Azure Storage Account.

## Usage

### ESLZ module block (`ESLZ/storage_account.tf`)

```hcl
module "storage_account" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-storage_account?ref=v4.0.0"
  for_each = var.storage_account

  env               = var.env
  userDefinedString = each.key
  resource_group    = var.resource_groups[each.value.resource_group]
  tags              = try(each.value.tags, {})
  # ... see ESLZ/storage_account.tf for the full set of passed-through arguments
}
```

### ESLZ tfvars pattern (`ESLZ/storage_account.tfvars`)

```hcl
storage_account = {
  myapp = {
    resource_group = "rg-example"
    tags           = { environment = "dev" }
  }
}
```

### Static website hosting (azurerm >= 4.x)

`static_website` is no longer an inline block on `azurerm_storage_account`. Set
`static_website_enabled = true` and the module provisions the companion
`azurerm_storage_account_static_website` resource for you; `static_website_index_document`
and `static_website_error_404_document` configure it.

## Testing

```bash
terraform fmt -recursive && terraform init -backend=false && terraform validate && terraform test
```

## CI

GitHub Actions workflow at `.github/workflows/terraform-ci.yml` runs fmt, init, validate, test and
tflint on every PR.

<!-- BEGIN_TF_DOCS -->
# Deploys an Azure Storage Account

Creates an Azure Storage Account.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 5.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_static_website.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_static_website) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. Defaults to true. | `bool` | `false` | no |
| <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope) | (Optional) The permitted scope for copy operations between storage accounts. Possible values are AAD, PrivateLink and All. | `string` | `null` | no |
| <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication) | (Optional) An azure\_files\_authentication block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#azure_files_authentication | `any` | `null` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | (Optional) A blob\_properties block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#blob_properties | `any` | `null` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | (Optional) Should cross Tenant replication be enabled? Defaults to false. | `bool` | `null` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | (Optional) A custom\_domain block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#custom_domain | `any` | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | (Optional) A customer\_managed\_key block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#customer_managed_key | `any` | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false | `bool` | `false` | no |
| <a name="input_dns_endpoint_type"></a> [dns\_endpoint\_type](#input\_dns\_endpoint\_type) | (Optional) Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) env value | `string` | n/a | yes |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | (Optional) Enable default outbound access to the internet for the subnet. Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#identity | `any` | `null` | no |
| <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy) | (Optional) An immutability\_policy block. Changing this forces a new resource to be created. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#immutability_policy | `any` | `null` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | (Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `null` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | (Optional) Are Large File Shares Enabled? Defaults to false. | `bool` | `null` | no |
| <a name="input_local_user_enabled"></a> [local\_user\_enabled](#input\_local\_user\_enabled) | (Optional) Is Local User Enabled? Defaults to true. | `bool` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | (Optional) A network\_rules block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#network_rules | `any` | `null` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | (Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_provisioned_billing_model_version"></a> [provisioned\_billing\_model\_version](#input\_provisioned\_billing\_model\_version) | (Optional) Specifies the version of the provisioned billing model (e.g. when account\_kind = FileStorage for Storage File). Possible value is V2. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type) | (Optional) The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. | `string` | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group object of the Storage Account to be created | `any` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | (Optional) A routing block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#routing | `any` | `null` | no |
| <a name="input_sas_policy"></a> [sas\_policy](#input\_sas\_policy) | (Optional) A sas\_policy block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#sas_policy | `any` | `null` | no |
| <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled) | (Optional) Boolean, enable SFTP for the storage account. Requires is\_hns\_enabled to be true. Defaults to false. | `bool` | `null` | no |
| <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties) | (Optional) A share\_properties block. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#share_properties | `any` | `null` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | (Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true. | `bool` | `true` | no |
| <a name="input_static_website_enabled"></a> [static\_website\_enabled](#input\_static\_website\_enabled) | (Optional) Enable static website hosting for this Storage Account. Provisions a companion azurerm\_storage\_account\_static\_website resource (azurerm >= 4.x split this out of azurerm\_storage\_account). Defaults to false. | `bool` | `false` | no |
| <a name="input_static_website_error_404_document"></a> [static\_website\_error\_404\_document](#input\_static\_website\_error\_404\_document) | (Optional) The absolute path to a custom webpage used when a request is made which does not correspond to an existing file. Only used when static\_website\_enabled is true. | `string` | `null` | no |
| <a name="input_static_website_index_document"></a> [static\_website\_index\_document](#input\_static\_website\_index\_document) | (Optional) The webpage that Azure Storage serves for requests to the root of the static website or any subfolder. Only used when static\_website\_enabled is true. Defaults to index.html. | `string` | `"index.html"` | no |
| <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type) | (Optional) The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the Storage Account to be created | `map(string)` | n/a | yes |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | UserDefinedString part of the name of the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | returns the ID of Storage Account |
| <a name="output_name"></a> [name](#output\_name) | returns the name of Storage Account |
| <a name="output_object"></a> [object](#output\_object) | returns the full Azure Storage Account Object |
| <a name="output_primary_web_host"></a> [primary\_web\_host](#output\_primary\_web\_host) | web host of Storage Account |
<!-- END_TF_DOCS -->
