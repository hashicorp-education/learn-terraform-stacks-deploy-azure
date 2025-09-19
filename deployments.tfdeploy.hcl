# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "azurerm" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "production" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    client_id       = "04b07795-8ddb-461a-bbee-02f9e1bf7b46"
    subscription_id = "08fd09b4-a6f5-4d77-979c-53cc488bd179"
    tenant_id       = "53b7328c-caf4-40fb-b84e-04b3f4bcf38f"
  }
}

deployment "development" {
  inputs = {
    identity_token = identity_token.azurerm.jwt

    client_id       = "04b07795-8ddb-461a-bbee-02f9e1bf7b46"
    subscription_id = "08fd09b4-a6f5-4d77-979c-53cc488bd179"
    tenant_id       = "53b7328c-caf4-40fb-b84e-04b3f4bcf38f"
  }
}
