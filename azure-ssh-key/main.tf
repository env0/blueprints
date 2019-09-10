# adapted from https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-create-complete-vm

provider "azurerm" {}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "myterraformgroup" {
  name     = "env0-ssh-key-${random_string.random.result}"
  location = "eastus"
}

resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "${azurerm_resource_group.myterraformgroup.name}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
}

resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "${azurerm_resource_group.myterraformgroup.name}-subnet"
  resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
  virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "${azurerm_resource_group.myterraformgroup.name}-public-ip"
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "${azurerm_resource_group.myterraformgroup.name}-sg"
  location            = "eastus"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "myterraformnic" {
  name                      = "${azurerm_resource_group.myterraformgroup.name}-nic"
  location                  = "eastus"
  resource_group_name       = "${azurerm_resource_group.myterraformgroup.name}"
  network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = "${azurerm_subnet.myterraformsubnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.myterraformpublicip.id}"
  }
}

resource "azurerm_virtual_machine" "myterraformvm" {
  name                  = "${azurerm_resource_group.myterraformgroup.name}-vm"
  location              = "eastus"
  resource_group_name   = "${azurerm_resource_group.myterraformgroup.name}"
  network_interface_ids = ["${azurerm_network_interface.myterraformnic.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myvm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureuser/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/azure_test.pub")}"
    }
  }
}

data "azurerm_public_ip" "ip_for_output" {
  name                = "${azurerm_public_ip.myterraformpublicip.name}"
  resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
}

output "public_ip_address" {
  value = "${data.azurerm_public_ip.ip_for_output.ip_address}"
}
