terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_linux_virtual_machine" "compute" {
  count               = var.node_count
  name                = "${var.cluster_name}-node${format("%02d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [azurerm_network_interface.compute[count.index].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.tags, {
    Role        = "compute-node"
    ClusterName = var.cluster_name
  })
}

resource "azurerm_network_interface" "compute" {
  count               = var.node_count
  name                = "${var.cluster_name}-nic-node${format("%02d", count.index + 1)}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_managed_disk" "scratch" {
  count                = var.node_count
  name                 = "${var.cluster_name}-scratch-node${format("%02d", count.index + 1)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.scratch_disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "scratch" {
  count              = var.node_count
  managed_disk_id    = azurerm_managed_disk.scratch[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.compute[count.index].id
  lun                = 10
  caching            = "None"
}
