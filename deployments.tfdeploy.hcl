# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "azurerm" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "production" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    regions = ["East US", "West US"]

    client_id       = "ea561fee-30d7-4b92-9867-1d38781b7c00"
    subscription_id = "08fd09b4-a6f5-4d77-979c-53cc488bd179"
    tenant_id       = "53b7328c-caf4-40fb-b84e-04b3f4bcf38f"
  }

  destroy = true
}

deployment "development" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    regions = ["East US"]

    client_id       = "ea561fee-30d7-4b92-9867-1d38781b7c00"
    subscription_id = "08fd09b4-a6f5-4d77-979c-53cc488bd179"
    tenant_id       = "53b7328c-caf4-40fb-b84e-04b3f4bcf38f"
  }

  destroy = true
}
