output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.stacks.name
}

output "resource_group_location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.stacks.location
}

output "private_key_pem" {
  description = "Private key material in PEM format."
  value       = tls_private_key.stack.private_key_pem
  sensitive   = true
}

output "public_key_pem" {
  description = "Public key material in PEM format."
  value       = tls_private_key.stack.public_key_pem
}

output "public_key_openssh" {
  description = "Public key material in openSSH format."
  value       = tls_private_key.stack.public_key_openssh
}
