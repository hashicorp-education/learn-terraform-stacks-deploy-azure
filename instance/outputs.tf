# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance_ids" {
  description = "IDs of Linux virtual machines."
  value       = azurerm_linux_virtual_machine.private[*].id
}

output "private_ips" {
  description = "Private IP addresses of Linux virtual machines."
  value       = [for nic in azurerm_network_interface.private : nic.ip_configuration[0].private_ip_address]
}
