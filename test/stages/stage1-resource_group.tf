module "resource_group" {
  source = "github.com/ibm-garage-cloud/terraform-azure-resource-group"

  resource_group_name = var.resource_group_name
  region              = var.region
}
