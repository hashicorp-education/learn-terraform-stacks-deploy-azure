resource "random_pet" "group_name" {
  prefix = "stacks"

  length = 2
}

resource "azurerm_resource_group" "stacks" {
  name     = "stacks-${random_pet.group_name.id}"
  location = var.region
}

resource "tls_private_key" "stack" {
  algorithm = "ED25519"
}
