# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "random_pet" "function_name" {
  prefix = "stacks"
  length = 2
}

data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/hello-world"
  output_path = "/tmp/hello-world.zip"
}

resource "azurerm_storage_blob" "function_zip" {
  name                   = "hello-world.zip"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source                 = data.archive_file.function_zip.output_path
}

resource "azurerm_service_plan" "function_plan" {
  name                = "function-plan"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  os_type             = "Linux"
  sku_name            = "B1"
}

data "azurerm_storage_account_sas" "function_zip_sas" {
  connection_string = var.storage_account_primary_connection_string

  https_only = true
  start      = timestamp()
  expiry     = timeadd(timestamp(), "1h")

  resource_types {
    service   = false
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}

locals {
  blob_url_with_sas = "${azurerm_storage_blob.function_zip.url}?${data.azurerm_storage_account_sas.function_zip_sas.sas}"
}

resource "azurerm_linux_function_app" "function_func" {
  name                       = "hello-world-${random_pet.function_name.id}"
  resource_group_name        = var.resource_group_name
  location                   = var.resource_group_location
  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key

  site_config {
    application_insights_connection_string = azurerm_application_insights.function_logs.connection_string

    application_stack {
      node_version = "18"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"       = local.blob_url_with_sas
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.function_logs.instrumentation_key
  }
}

resource "azurerm_application_insights" "function_logs" {
  name                = "appinsights-hello-world"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  application_type    = "web"
}
