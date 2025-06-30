# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "function_name" {
  description = "Name of the Azure Function App."
  value       = azurerm_linux_function_app.function.name
}

output "invoke_url" {
  description = "The base URL to invoke the Azure Function App (e.g., with /api/{route})."
  value       = "https://${azurerm_linux_function_app.function.default_hostname}/api/hello"
}
