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
