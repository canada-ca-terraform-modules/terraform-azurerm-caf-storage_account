## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_kind | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. | `string` | `"StorageV2"` | no |
| account\_replication\_type | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. | `string` | `"GRS"` | no |
| account\_tier | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| allow\_nested\_items\_to\_be\_public | Allow or disallow nested items within this Account to opt into being public. Defaults to true. | `bool` | `false` | no |
| enable\_https\_traffic\_only | (Optional) Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true. | `bool` | `true` | no |
| env | (Required) env value | `string` | n/a | yes |
| is\_hns\_enabled | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/ for more information). Changing this forces a new resource to be created. | `bool` | `false` | no |
| min\_tls\_version | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |
| resource\_group | Resource group object of the AKV to be created | `any` | n/a | yes |
| tags | Tags to be applied to the AKV to be created | `map(string)` | n/a | yes |
| userDefinedString | UserDefinedString part of the name of the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | returns the ID of Storage Account |
| name | returns the name of Storage Account |
| object | returns the full Azure Storage Account Object |

