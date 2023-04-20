# Azure Jumpbox
Terraform module to create a jumpbox. A jumpbox is an Azure virtual machine (VM) that's running Linux or Windows that has password authentication enabled and to which users can connect via the Remote Desktop Protocol (RDP) or Secure Shell (SSH).

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.jumpbox_vm_linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.jumpbox_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.jumpbox_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.jumpbox_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_windows_virtual_machine.jumpbox_vm_windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | n/a | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | n/a | `string` | n/a | yes |
| <a name="input_computer_name"></a> [computer\_name](#input\_computer\_name) | n/a | `string` | `null` | no |
| <a name="input_create_linux_host"></a> [create\_linux\_host](#input\_create\_linux\_host) | n/a | `bool` | `true` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | n/a | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the jumphost resources to create. | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | n/a | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | n/a | `string` | `null` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | n/a | `string` | `"Standard_LRS"` | no |
| <a name="input_private_ip_address_allocation"></a> [private\_ip\_address\_allocation](#input\_private\_ip\_address\_allocation) | n/a | `string` | `"Dynamic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to be imported. | `string` | n/a | yes |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | n/a | <pre>map(object({<br>    name                       = string<br>    priority                   = number<br>    direction                  = string<br>    access                     = string<br>    protocol                   = string<br>    source_port_range          = string<br>    destination_port_range     = string<br>    source_address_prefix      = string<br>    destination_address_prefix = string<br>  }))</pre> | <pre>{<br>  "Inbound_100": {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Inbound",<br>    "name": "SSH",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  },<br>  "Outbound_100": {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_range": "22",<br>    "direction": "Outbound",<br>    "name": "SSH-out",<br>    "priority": 100,<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_range": "*"<br>  }<br>}</pre> | no |
| <a name="input_source_image_offer_linux"></a> [source\_image\_offer\_linux](#input\_source\_image\_offer\_linux) | n/a | `string` | `"UbuntuServer"` | no |
| <a name="input_source_image_offer_windows"></a> [source\_image\_offer\_windows](#input\_source\_image\_offer\_windows) | n/a | `string` | `"WindowsServer"` | no |
| <a name="input_source_image_publisher_linux"></a> [source\_image\_publisher\_linux](#input\_source\_image\_publisher\_linux) | n/a | `string` | `"Canonical"` | no |
| <a name="input_source_image_publisher_windows"></a> [source\_image\_publisher\_windows](#input\_source\_image\_publisher\_windows) | n/a | `string` | `"MicrosoftWindowsServer"` | no |
| <a name="input_source_image_sku_linux"></a> [source\_image\_sku\_linux](#input\_source\_image\_sku\_linux) | n/a | `string` | `"18.04-LTS"` | no |
| <a name="input_source_image_sku_windows"></a> [source\_image\_sku\_windows](#input\_source\_image\_sku\_windows) | n/a | `string` | `"2022-Datacenter"` | no |
| <a name="input_source_image_version_linux"></a> [source\_image\_version\_linux](#input\_source\_image\_version\_linux) | n/a | `string` | `"latest"` | no |
| <a name="input_source_image_version_windows"></a> [source\_image\_version\_windows](#input\_source\_image\_version\_windows) | n/a | `string` | `"latest"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the jumphost virtual machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jumpbox_subnet_id"></a> [jumpbox\_subnet\_id](#output\_jumpbox\_subnet\_id) | The subnet ID. |
| <a name="output_location"></a> [location](#output\_location) | The location of the jumphost resources to create. |
| <a name="output_nic_id"></a> [nic\_id](#output\_nic\_id) | The ID of the network interface of the jumpbox vm. |
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | The ID of the network security group of the jumpbox vm. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Primary Private IP Address assigned to the jumpbox vm. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group to be imported. |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | The 128-bit identifier which uniquely identifies this jumpbox vm. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The ID of the jumpbox vm. |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the jumpbox vm. |
| <a name="output_vm_size"></a> [vm\_size](#output\_vm\_size) | The size of the jumpbox vm. |