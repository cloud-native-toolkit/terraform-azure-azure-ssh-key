module "azure_ssh_key" {
  source = "./module"

  key_name            = "test-key"
  resource_group_name = module.resource_group.name
  region              = var.region
}
