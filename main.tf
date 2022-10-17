locals {
  store_path = var.store_path == "" ? "${path.cwd}" : "${var.store_path}"
  key_name   = var.key_name == "" ? var.name_prefix == "" ? "${random_string.prefix[0].result}-key" : "${var.name_prefix}-key" : var.key_name
  public_key_file = "${local.store_path}/${local.key_name}.pub"
  private_key_file = "${local.store_path}/${local.key_name}"
}

resource "random_string" "prefix" {
    count = var.key_name == "" && var.name_prefix == "" ? 1 : 0

    length = 5
    special = false
    upper = false
}

resource "tls_private_key" "key" {
    count     = var.ssh_key == "" ? 1 : 0

    algorithm = var.algorithm
    rsa_bits  = var.algorithm == "RSA" ? var.rsa_bits : null
    ecdsa_curve = var.algorithm == "ECDSA" ? var.ecdsa_curve : null
}

resource "local_file" "private_key" {
    count           = var.ssh_key == "" ? 1 : 0

    content         = tls_private_key.key[0].private_key_pem
    filename        = local.private_key_file
    file_permission = var.file_permissions
}

resource "local_file" "public_key" {
    count           = var.ssh_key == "" ? 1 : 0
    
    content         = tls_private_key.key[0].public_key_openssh
    filename        = local.public_key_file
    file_permission = var.file_permissions
}

data "local_file" "pub_key" {
    depends_on = [
      local_file.public_key
    ]

    filename        = local.public_key_file
}

data "local_file" "private_key" {
    depends_on = [
      local_file.private_key
    ]

    filename = local.private_key_file
}

resource "azurerm_ssh_public_key" "ssh_key" {
    count = var.store_key_in_vault ? 1 : 0

    name                = local.key_name
    resource_group_name = var.resource_group_name
    location            = var.region
    public_key          = var.ssh_key == "" ? data.local_file.pub_key.content : file(var.ssh_key)
    tags                = var.tags
}