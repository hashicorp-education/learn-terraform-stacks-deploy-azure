# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "storage_account_name" {
  description = "Name of the storage account."
  type        = string
  #  value = azurerm_storage_account.function_storage.name
}

variable "storage_account_primary_access_key" {
  description = "Access key for the storage account."
  type        = string
  sensitive   = true
  #azurerm_storage_account.function_storage.primary_access_key  
}

variable "storage_container_name" {
  description = "Name of the storage container."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group."
  type        = string
}
