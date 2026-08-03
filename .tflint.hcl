config {
  call_module_type = "local"
  force            = false
}

plugin "azurerm" {
  enabled = true
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
  version = "0.32.0"
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}

# Pre-existing repo convention uses hyphenated local names and a camelCase
# public variable (userDefinedString) consumed by every caller. Renaming
# either is a breaking change out of scope for a provider version upgrade.
rule "terraform_naming_convention" {
  enabled = false
}

# Opinionated lifecycle policy, unrelated to azurerm v5 compatibility;
# left to the module owner to opt into per-deployment via caller overrides.
rule "azurerm_resources_missing_prevent_destroy" {
  enabled = false
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}
