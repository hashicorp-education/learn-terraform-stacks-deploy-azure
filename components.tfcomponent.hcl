# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

component "resource_group" {
  for_each = var.regions

  source = "./resource_group"

  inputs = {
    region = each.value
  }

  providers = {
    azurerm = provider.azurerm.configurations[each.value]
    random  = provider.random.this
  }
}

component "storage" {
  for_each = var.regions

  source = "./storage"

  inputs = {
    resource_group_name     = component.resource_group[each.value].resource_group_name
    resource_group_location = component.resource_group[each.value].resource_group_location
  }

  providers = {
    azurerm = provider.azurerm.configurations[each.value]
    random  = provider.random.this
  }
}

component "function" {
  for_each = var.regions

  source = "./function"

  inputs = {
    storage_account_name = component.storage[each.value].storage_account_name
    storage_account_primary_access_key = component.storage[each.value].storage_account_primary_access_key
    storage_container_name = component.storage[each.value].storage_container_name
    resource_group_name = component.resource_group[each.value].resource_group_name
    resource_group_location = component.resource_group[each.value].resource_group_location
    storage_account_primary_connection_string = component.storage[each.value].storage_account_primary_connection_string
  }

  providers = {
    azurerm = provider.azurerm.configurations[each.value]
    archive = provider.archive.this
    random  = provider.random.this
  }
}
