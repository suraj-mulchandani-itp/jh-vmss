################################################################################
# Locals Block
################################################################################
locals {
  resource_group_name = join("-", compact([var.prefix, var.environment, var.resource_group_name, "rg"]))
  hub_vnet_name       = join("-", compact([var.prefix, var.environment, var.location, var.hub_vnet_name, "vnet"]))
  jumphost_vm_name    = join("-", compact([var.prefix, var.environment, var.location, var.jumphost_vm_name, "vm"]))
}
################################################################################
# Datasources Block
################################################################################
data "azurerm_resource_group" "hub" {
  name = local.resource_group_name
}

data "azurerm_virtual_network" "hub" {
  name                = local.hub_vnet_name
  resource_group_name = data.azurerm_resource_group.hub.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.hub.name
  virtual_network_name = data.azurerm_virtual_network.hub.name
}

################################################################################
# JumpBox Module
################################################################################
module "jump_host" {
  source = "../modules/azure-vm"

  resource_group_name = data.azurerm_resource_group.hub.name
  location            = data.azurerm_resource_group.hub.location

  vm_name = local.jumphost_vm_name
  vm_size = var.jumphost_vm_size

  subnet_id = data.azurerm_subnet.subnet.id

  create_windows_host = true
  create_linux_host   = false

  # disable_password_authentication = var.jumphost_disable_password_authentication
  admin_username                  = var.jumphost_admin_username
  admin_password                  = var.jumphost_admin_password

  key_vault_name = var.key_vault_name
  key_name       = var.key_name

  source_image_offer     = var.windows_source_image_offer
  source_image_publisher = var.windows_source_image_publisher
  source_image_version   = var.windows_source_image_version
  source_image_sku       = var.windows_source_image_sku

  vm_extension_file_name     = var.vm_extension_file_name
  vm_extension_file_uri      = var.vm_extension_file_uri
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  tags = var.tags

}