output "resource_group_name" {
  description = "The name of the resource group to be imported."
  value       = data.azurerm_resource_group.main.name
}

output "location" {
  description = "The location of the jumphost resources to create."
  value       = data.azurerm_resource_group.main.location
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to the jumpbox vm."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_name" {
  description = "The name of the vm."
  value       = coalesce(try(azurerm_linux_virtual_machine.linux_vm[0].name, ""), try(azurerm_windows_virtual_machine.windows_vm[0].name, ""))
}

output "vm_size" {
  description = "The size of the vm."
  value       = coalesce(try(azurerm_linux_virtual_machine.linux_vm[0].size, ""), try(azurerm_windows_virtual_machine.windows_vm[0].size, ""))
}

output "vm_id" {
  description = "The ID of the jumpbox vm."
  value       = coalesce(try(azurerm_linux_virtual_machine.linux_vm[0].id, ""), try(azurerm_windows_virtual_machine.windows_vm[0].id, ""))
}

output "virtual_machine_id" {
  description = "The 128-bit identifier which uniquely identifies this jumpbox vm."
  value       = coalesce(try(azurerm_linux_virtual_machine.linux_vm[0].virtual_machine_id, ""), try(azurerm_windows_virtual_machine.windows_vm[0].virtual_machine_id, ""))
}

output "jumpbox_subnet_id" {
  description = "The subnet ID."
  value       = azurerm_network_interface.nic.ip_configuration[0].subnet_id
}

output "nic_id" {
  description = "The ID of the network interface of the jumpbox vm."
  value       = azurerm_network_interface.nic.id
}

output "nsg_id" {
  description = "The ID of the network security group of the jumpbox vm."
  value       = azurerm_network_security_group.nsg.id
}

output "key_resource_id" {
  description = "The resource id of the existing key present in the Key Vault."
  value       = data.azurerm_key_vault_key.key.resource_id
}

output "secret_name" {
  description = "The name of the existing secret present in the Key Vault."
  value = data.azurerm_key_vault_secret.example.name
}