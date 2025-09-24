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
    tls     = provider.tls.this
  }
}

component "network" {
  for_each = var.regions

  source = "./network"

  inputs = {
    resource_group_name     = component.resource_group[each.value].resource_group_name
    resource_group_location = component.resource_group[each.value].resource_group_location
  }

  providers = {
    azurerm = provider.azurerm.configurations[each.value]
  }
}

component "instance" {
  for_each = var.regions

  source = "./instance"

  inputs = {
    subnet_ids              = component.network[each.value].private_subnet_ids
    resource_group_name     = component.resource_group[each.value].resource_group_name
    resource_group_location = component.resource_group[each.value].resource_group_location
    security_group_id       = component.network[each.value].allow_ssh_security_group_id
    public_key_openssh      = component.resource_group[each.value].public_key_openssh
  }

  providers = {
    azurerm = provider.azurerm.configurations[each.value]
  }
}
