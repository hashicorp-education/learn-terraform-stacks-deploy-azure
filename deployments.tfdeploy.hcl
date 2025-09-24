# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "azurerm" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "development" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    regions = ["East US"]

    client_id       = "<YOUR_AZURE_CLIENT_ID>"
    subscription_id = "<YOUR_AZURE_SUBSCRIPTION_ID>"
    tenant_id       = "<YOUR_AZURE_TENANT_ID>"
  }
}

deployment "production" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    regions = ["East US", "West US"]

    client_id       = "<YOUR_AZURE_CLIENT_ID>"
    subscription_id = "<YOUR_AZURE_SUBSCRIPTION_ID>"
    tenant_id       = "<YOUR_AZURE_TENANT_ID>"
  }
}
