output "private_subnet_ids" {
  description = "IDs of private subnets."
  value       = azurerm_subnet.private.*.id
}

output "allow_ssh_security_group_id" {
  description = "ID of security group allowing SSH traffic."
  value       = azurerm_network_security_group.allow_ssh.id
}
