# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "regions" {
  type = set(string)
}

variable "identity_token" {
  type      = string
  ephemeral = true
}

variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "tenant_id" {
  type = string
}
