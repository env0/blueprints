provider "azurerm" {}

variable "ssh_public_key" {}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "resource_group" {
  name     = "env0-ssh-key-${random_string.random.result}"
  location = "northeurope"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${azurerm_resource_group.resource_group.name}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${azurerm_resource_group.resource_group.name}-subnet"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_virtual_machine_scale_set" "test" {
  name                = "${azurerm_resource_group.resource_group.name}-scale-set"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name      = "TestIPConfiguration"
      primary   = true
      subnet_id = "${azurerm_subnet.subnet.id}"
    }
  }

  os_profile {
    computer_name_prefix = "testvm"
    admin_username       = "myadmin"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/myadmin/.ssh/authorized_keys"
      key_data = "${var.ssh_public_key}"
    }
  }

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 1
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  upgrade_policy_mode = "Rolling"
}
