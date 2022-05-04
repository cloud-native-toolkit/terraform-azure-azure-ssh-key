
resource "tls_private_key" "key" {
    count     = var.ssh_key == "" ? 1 : 0

    algorithm = var.algorithm
    rsa_bits  = var.algorithm == "RSA" ? var.rsa_bits : null
    ecdsa_curve = var.algorithm == "ECDSA" ? var.ecdsa_curve : null
}

resource "local_file" "private_key" {
    count           = var.ssh_key == "" ? 1 : 0

    content         = tls_private_key.key[0].private_key_pem
    filename        = var.store_path == "" ? "${path.cwd}/${var.key_name}" : "${path.root}/${var.store_path}/${var.key_name}"
    file_permission = var.file_permissions
}

resource "local_file" "public_key" {
    count           = var.ssh_key == "" ? 1 : 0
    
    content         = tls_private_key.key[0].public_key_openssh
    filename        = var.store_path == "" ? "${path.cwd}/${var.key_name}.pub" : "${path.root}/${var.store_path}/${var.key_name}.pub"
    file_permission = var.file_permissions
}

data "local_file" "pub_key" {
    depends_on = [
      local_file.public_key
    ]

    filename        = var.store_path == "" ? "${path.cwd}/${var.key_name}.pub" : "${path.root}/${var.store_path}/${var.key_name}.pub"
}

resource "azurerm_ssh_public_key" "ssh_key" {
    count = var.store_key_in_vault ? 1 : 0

    name                = var.key_name
    resource_group_name = var.resource_group_name
    location            = var.region
    public_key          = var.ssh_key == "" ? data.local_file.pub_key.content : file(var.ssh_key)
    tags                = var.tags
}