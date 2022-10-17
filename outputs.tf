output "id" {
    description = "Azure vault identification of the stored key"
    value       = length(azurerm_ssh_public_key.ssh_key) > 0 ? azurerm_ssh_public_key.ssh_key[0].id : ""
}

output "pub_key" {
  description = "Public key"
  value       = data.local_file.pub_key.content
}

output "pub_key_file" {
  description = "File location of public key"
  value       = data.local_file.pub_key.filename
}

output "private_key" {
  description = "Private Key"
  sensitive   = true
  value       = data.local_file.private_key.content
}

output "private_key_file" {
  description = "Filename of the private key"
  value       = data.local_file.private_key.filename
}

output "path" {
  description = "Path to where keys are stored in filesystem"
  value       = local.store_path
  depends_on  = [
    data.local_file.pub_key, data.local_file.private_key
  ]
}

output "name" {
  description = "Name of the key created"
  value       = local.key_name
  depends_on  = [
    data.local_file.pub_key
  ]
}