###################### Resource Group and Location variables #####################

variable "resource_group_name" {
  type        = string
  description = "Azure Data Center Location"
}

variable "location" {
  type        = string
  description = "Azure Data Center Location"
  default     = "East US"
}

###################### Common Environment related variables #####################
variable "environment" {
  type        = string
  description = "Name of the environment"
  default     = "dev"
}

variable "prefix" {
  type        = string
  description = "Prefix to be added to the resource name."
  default     = ""
}

variable "hub_vnet_name" {

}

variable "subnet_name" {}
###################### Jumphost VM variables #####################
variable "jumphost_vm_name" {
  default = "jumphost"
}

variable "jumphost_vm_size" {
  default = "Standard_D2s_v3"
}

variable "jumphost_admin_username" {
  default = null
}

variable "jumphost_admin_password" {
  default = null
}

variable "jumphost_disable_password_authentication" {
  default = false
}

variable "windows_source_image_offer" {
  default = "WindowsServer"
}

variable "windows_source_image_publisher" {
  default = "MicrosoftWindowsServer"
}

variable "windows_source_image_version" {
  default = "latest"
}

variable "windows_source_image_sku" {
  default = "2019-Datacenter"
}

variable "key_vault_name" {
  type = string
  default = "suraj-demo-kv"
}

variable "key_name" {
  type = string
  default = "suraj-demo-key"
}

variable "vm_extension_file_uri" {
  default = ""
}

variable "vm_extension_file_name" {
  default = "userdata-windows.ps1"
}

variable "storage_account_name" {
  default = ""
}

variable "storage_account_access_key" {
  default = ""
}


###################### Common Tags variables #####################
variable "tags" {

  default = {}
}