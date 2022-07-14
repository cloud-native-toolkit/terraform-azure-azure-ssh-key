output "id" {
    description = "Azure vault identification of the stored key"
    value = length(azurerm_ssh_public_key.ssh_key) > 0 ? azurerm_ssh_public_key.ssh_key[0].id : ""

    depends_on = [
      azurerm_ssh_public_key.ssh_key
    ]
}

output "pub_key" {
  description = "Public key"

  value = data.local_file.pub_key.content

  depends_on = [
    data.local_file.pub_key
  ]
}

output "pub_key_file" {
  description = "File location of public key"

  value = data.local_file.pub_key.filename

  depends_on = [
    data.local_file.pub_key
  ]
}

output "path" {
  description = "Path to where keys are stored in filesystem"
  value = local.store_path
}