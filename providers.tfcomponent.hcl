# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~> 4.34"
  }
  archive = {
    source  = "hashicorp/archive"
    version = "~> 2.7"
  }
  random = {
    source  = "hashicorp/random"
    version = "~> 3.7"
  }
}

provider "azurerm" "configurations" {
  for_each = var.regions

  config {
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }

    use_cli         = false
    use_oidc        = true
    subscription_id = var.subscription_id
    client_id       = var.client_id
    tenant_id       = var.tenant_id
  }
}

provider "random" "this" {}
provider "archive" "this" {}
