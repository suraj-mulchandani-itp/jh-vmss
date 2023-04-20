provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name = "es-prod-hub-rg"
}

data "azurerm_virtual_network" "vnet" {
  name                = "es-prod-eastus-hub-vnet"
  resource_group_name = data.azurerm_resource_group.main.name
}


data "azurerm_subnet" "jumpbox_subnet" {
  name                 = "es-prod-eastus-mgt-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.main.name
}


module "azure_jumphost" {
  source = "../.."

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  vm_name             = "test-windows-vm-1"
  vm_size             = "Standard_D2s_v3"
  computer_name       = "test-windows-vm"

  # vnet_address_space      = var.vnet_address_space
  # subnet_address_prefixes = var.subnet_address_prefixes

  subnet_id = data.azurerm_subnet.jumpbox_subnet.id

  disable_password_authentication = "false"
  admin_username                  = "imm-admin"
  admin_password                  = "IMM@12345678!"
  fileUri                         = "https://esvmcustomscripts.blob.core.windows.net/script/userdata-windows.ps1"
  storage_account_name            = "esvmcustomscripts"
  storage_account_access_key      = "Cce5oIhkUdWsT7ubFozCAVtoC4Z1wUZTZygICw+6zv0VUDjPDTeXfDa/TIYhoJ4oSMOwp84JHSee+AStMcKdww=="

  source_image_sku_windows       = "2019-datacenter-with-containers-g2"
  source_image_publisher_windows = "MicrosoftWindowsServer"
  source_image_offer_windows     = "WindowsServer"
  source_image_version_windows   = "latest"

  create_linux_host = false
}