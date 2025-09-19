# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "storage_container_name" {
  description = "The name of the storage container."
  value       = azurerm_storage_container.function_container.name
}

output "primary_connection_string" {
  description = "Storage account connection string"
  value = azurerm_storage_account.function_storage.primary_connection_string
}
