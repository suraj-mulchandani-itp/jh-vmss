variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to be imported."
}

variable "location" {
  type        = string
  description = "The location of the jumphost resources to create."
}


variable "subnet_id" {
  type = string
}

variable "vm_name" {
  type        = string
  description = "The name of the jumphost virtual machine."
}

variable "computer_name" {
  type    = string
  default = null
}

variable "vm_size" {
  type = string
}

variable "disable_password_authentication" {
  type    = bool
  default = false
}

variable "key_vault_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "os_disk_name" {
  type    = string
  default = null
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "source_image_publisher" {
  type    = string
  default = "Canonical"
}

variable "source_image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "source_image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "source_image_version" {
  type    = string
  default = "latest"
}


variable "create_linux_host" {
  type    = bool
  default = true
}

variable "create_windows_host" {
  type    = bool
  default = false
}

variable "security_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {
    Inbound_100 = {
      name                       = "SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    Outbound_100 = {
      name                       = "SSH-out"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

variable "private_ip_address_allocation" {
  default = "Dynamic"
}


variable "vm_extension_publisher" {
  default = "Microsoft.Compute"
}

variable "vm_extension_type" {
  default = "CustomScriptExtension"
}


variable "vm_extension_type_handler_version" {
  default = "1.10"
}

variable "vm_extension_file_uri" {
  default = ""
}

variable "vm_extension_file_name" {
  default = "userdata-windows.ps1"
}


variable "storage_account_access_key" {
  default = null
}

variable "storage_account_name" {
  default = null
}

variable "user_data" {
  default = null
}


variable "tags" {
  default = {}
}