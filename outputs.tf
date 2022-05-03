output "id" {
    description = "Azure vault identification of the stored key"
    value = length(azurerm_ssh_public_key.ssh_key) > 0 ? azurerm_ssh_public_key.ssh_key[0].id : ""

    depends_on = [
      azurerm_ssh_public_key.ssh_key
    ]
}