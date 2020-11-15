# Deploys an Azure Storage Account

Creates an Azure Storage Account.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azurerm | >= 2.34.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.34.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | (Required) env value | `string` | n/a | yes |
| resource\_group | Resource group object of the AKV to be created | `any` | n/a | yes |
| tags | Tags to be applied to the AKV to be created | `map(string)` | n/a | yes |
| userDefinedString | UserDefinedString part of the name of the resource | `string` | n/a | yes |
| account\_kind | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. | `string` | `"StorageV2"` | no |
| account\_replication\_type | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `"GRS"` | no |
| account\_tier | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| allow\_blob\_public\_access | Allow or disallow public access to all blobs or containers in the storage account. | `bool` | `false` | no |
| is\_hns\_enabled | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created. | `bool` | `false` | no |
| min\_tls\_version | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | returns the ID of Storage Account |
| name | returns the name of Storage Account |
| object | returns the full Azure Storage Account Object |

