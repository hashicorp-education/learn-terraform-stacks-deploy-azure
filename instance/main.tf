resource "azurerm_network_interface" "private" {
  count               = length(var.subnet_ids) * var.instances_per_subnet
  name                = "nic-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[count.index % length(var.subnet_ids)]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "private" {
  count                     = length(var.subnet_ids) * var.instances_per_subnet
  network_interface_id      = azurerm_network_interface.private[count.index].id
  network_security_group_id = var.security_group_id
}

resource "azurerm_linux_virtual_machine" "private" {
  count               = length(var.subnet_ids) * var.instances_per_subnet
  name                = "vm-${count.index}"
  size                = var.instance_type
  admin_username      = "ubuntu"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  network_interface_ids = [
    azurerm_network_interface.private[count.index].id
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = var.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-noble"
    sku       = "24_04-lts"
    version   = "latest"
  }
}
