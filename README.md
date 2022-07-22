# Azure SSH Key

## Module overview

### Description

This module stores a public key into the Azure vault. If a key is not passed to the module, a new key pair is created and stored in the current working directory.

**Note:** This module follows the Terraform conventions regarding how provider configuration is defined within the Terraform template and passed into the module - https://www.terraform.io/docs/language/modules/develop/providers.html. The default provider configuration flows through to the module. If different configuration is required for a module, it can be explicitly passed in the `providers` block of the module - https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly.

### Software dependencies

The module depends on the following software components:

#### Command-line tools

- terraform >= v0.15

#### Terraform providers

- Azure provider >= 2.91.0

### Module dependencies

This module makes use of the output from other modules:

- Azure resource group - github.com/cloud-native-toolkit/terraform-azure-resource-group >= 1.0.2

### Example usage

```hcl-terraform
module "ssh_key" {
    source = "github.com/cloud-native-toolkit/terraform-azure-ssh-key"

    key_name = "test-key"
    resource_group_name = module.resource_group.name
    region= module.resource_group.region
    store_path = "${path.cwd}/${var.path_offset}"
  
}
```
