
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_key" "key" {
  name         = var.key_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "example" {
  name         = "suraj-demo-secret"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_network_security_group" "nsg" {
  name = join("-", [var.vm_name, "nsg"])

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

}

resource "azurerm_network_interface" "nic" {
  name = join("-", [var.vm_name, "nic"])

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count = var.create_linux_host ? 1 : 0

  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  name = var.vm_name
  size = var.vm_size

  computer_name = var.computer_name

  disable_password_authentication = var.disable_password_authentication
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  user_data = var.user_data

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  tags = merge({
    "name" = var.vm_name
    }, var.tags
  )

}

resource "azurerm_windows_virtual_machine" "windows_vm" {

  count = var.create_windows_host ? 1 : 0

  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size

  computer_name = substr(var.vm_name, 0, 6)

  admin_username = var.admin_username
  admin_password = data.azurerm_key_vault_secret.example.value

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = join("-", [var.vm_name, "osdisk"])
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  tags = merge({
    "name" = var.vm_name
    }, var.tags
  )

}

resource "azurerm_virtual_machine_extension" "extension" {
  count = var.create_windows_host ? 1 : 0

  name                 = "hostname1"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher            = var.vm_extension_publisher
  type                 = var.vm_extension_type
  type_handler_version = var.vm_extension_type_handler_version

  settings           = <<SETTINGS
    {
        "fileUris" : ["${var.vm_extension_file_uri}"],
        "commandToExecute" : "powershell -ExecutionPolicy Unrestricted -File ${var.vm_extension_file_name}"
    }
  SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
        "storageAccountName": "${var.storage_account_name}",
        "storageAccountKey": "${var.storage_account_access_key}"
    }
  PROTECTED_SETTINGS
}