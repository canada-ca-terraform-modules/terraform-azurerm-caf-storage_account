# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [4.0.0] - 2026-07-31

### Breaking

- **Static website configuration moved out of `azurerm_storage_account`.** azurerm v4+ removed the
  inline `static_website` block from `azurerm_storage_account`; it is now managed by the separate
  `azurerm_storage_account_static_website` resource. The module still exposes `static_website_enabled`
  (unchanged default `false`) and conditionally creates the companion resource — the storage account
  itself is never replaced by this change. Consumers with `static_website_enabled = true` today should
  run `terraform plan` after upgrading and, if desired, `terraform import
  azurerm_storage_account_static_website.storage_account[0] <storage_account_id>` to adopt the new
  resource into state without a fresh create.

### Added

- `providers.tf` pinning `azurerm ~> 5.0`, `required_version >= 1.9` (previously absent — the module
  had no explicit provider constraint since a 2022 commit accidentally dropped it).
- New pass-through arguments matching the azurerm v5 `azurerm_storage_account` schema: `edge_zone`,
  `cross_tenant_replication_enabled`, `large_file_share_enabled`, `local_user_enabled`,
  `queue_encryption_key_type`, `table_encryption_key_type`, `infrastructure_encryption_enabled`,
  `allowed_copy_scope`, `sftp_enabled`, `dns_endpoint_type`, `provisioned_billing_model_version`.
- New optional blocks: `network_rules`, `identity`, `blob_properties`, `customer_managed_key`,
  `custom_domain`, `share_properties`, `azure_files_authentication`, `routing`, `sas_policy`,
  `immutability_policy`. All are `null` by default — no plan diff for existing callers.
- `static_website_index_document` / `static_website_error_404_document` variables to configure the new
  companion resource (default `index_document` remains `index.html`, matching prior hardcoded behavior).
- `ESLZ/storage_account.tf` and `ESLZ/storage_account.tfvars` — module block and tfvars examples for
  L2 callers (previously absent).
- `tests/storage_account.tftest.hcl` and `tests/upgrade_compat.tftest.hcl` — `terraform test` coverage
  using `mock_provider` (19 runs total), including plan-only assertions for every new dynamic block
  (`customer_managed_key`, `custom_domain`, `share_properties`, `azure_files_authentication`, `routing`,
  `sas_policy`, `immutability_policy`) and a state-chained upgrade-safety test.
- `.tflint.hcl`, `.github/workflows/terraform-ci.yml` — tflint + `terraform test` CI, zero findings.
- `.gitattributes` enforcing LF line endings.

### Changed

- Fixed a bug where the computed `local.tags` (merging the module's `module` tag into caller tags) was
  never applied — the resource used `var.tags` directly, silently dropping the module tag on every
  deployment. The resource now uses `local.tags`.
- Fixed copy-paste variable descriptions on `tags` and `resource_group` that referenced "AKV" (Key
  Vault) instead of the Storage Account.
- `output.object` now marked `sensitive = true` — it exposes the full storage account object, including
  access keys and connection strings.
- `.gitignore` replaced with the standard template (adds `*.tfplan`, `override.tf`, IDE files, and an
  `!ESLZ/*.tfvars` exception preceded by an ignore rule).
- Bumped `actions/checkout` to `v7.0.1` and `terraform-docs/gh-actions` to `v1.4.1` in
  `.github/workflows/documentation.yml`.

### Removed

- Deleted `main.tf`'s unused `data "azurerm_client_config" "current"` data source — dead code since the
  module's first commit, never referenced anywhere.

### Known blockers

- None. Target version `azurerm ~> 5.0` (5.0.1) confirmed and used throughout.
