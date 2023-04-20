data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "jumpbox_vnet" {
  name                = "vnet"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "jumpbox_subnet" {
  name                 = "subnet"
  virtual_network_name = azurerm_virtual_network.jumpbox_vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name
  address_prefixes     = var.subnet_address_prefixes
}

module "azure_jumphost" {
  source = "../.."

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  computer_name       = var.computer_name

  # vnet_address_space      = var.vnet_address_space
  # subnet_address_prefixes = var.subnet_address_prefixes

  subnet_id = azurerm_subnet.jumpbox_subnet.id

  disable_password_authentication = var.disable_password_authentication
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  create_linux_host = false
}