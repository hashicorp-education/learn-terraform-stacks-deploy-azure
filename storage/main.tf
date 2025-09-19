# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "azurerm_storage_account" "function_storage" {
  name                     = random_string.storage_account_name.id
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {}
}

resource "azurerm_storage_container" "function_container" {
  name                  = "function-container"
  storage_account_name    = azurerm_storage_account.function_storage.name
  container_access_type = "private"
}
