###############################
#RD-Gateway Server
###############################
resource "azurerm_virtual_machine" "RDGW" {
  name                             = "C${var.region_code["${var.region}"]}WARDGW0${count.index + 1}P"
  location                         = "${var.region}"
  resource_group_name              = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids            = ["${azurerm_network_interface.RDGW_NIC.*.id}"]
  vm_size                          = "${var.instance_type}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "RDGW${count.index + 1}-RootVol"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "C${var.region_code["${var.region}"]}WARDGW0${count.index + 1}P"
    admin_username = "csiadmin"
    admin_password = "${var.rdgw_password}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent        = true
  }
}

#RD-Gateway Server Public Network Interface
resource "azurerm_network_interface" "RDGW_NIC" {
  name                = "RDGW-NIC${count.index + 1}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  ip_configuration {
    name                          = "RDGW-Private${count.index + 1}"
    subnet_id                     = "${element(azurerm_subnet.public_subnets.*.id,count.index)}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.RDGW_Public.id}"
  }
}

#RD-Gateway Server Public IP
resource "azurerm_public_ip" "RDGW_Public" {
  name                = "RDGW-Public${count.index + 1}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Static"
}

###############################
#Domain Controller / DNS Server
###############################
resource "azurerm_virtual_machine" "domain_controller" {
  name                             = "C${var.region_code["${var.region}"]}WADC0${count.index + 1}P"
  location                         = "${var.region}"
  resource_group_name              = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids            = ["${azurerm_network_interface.domain_controller_NIC.*.id}"]
  vm_size                          = "${var.domain_controller_instance_type}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "WADC0${count.index + 1}-RootVol"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "C${var.region_code["${var.region}"]}WADC0${count.index + 1}P"
    admin_username = "csiadmin"
    admin_password = "${var.domain_controller_password}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent        = true
  }
}

#Domain Controller / DNS Server Private Network Interface
resource "azurerm_network_interface" "domain_controller_NIC" {
  name                = "C${var.region_code["${var.region}"]}WADC0${count.index + 1}-NIC${count.index + 1}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  ip_configuration {
    name                          = "C${var.region_code["${var.region}"]}WADC0${count.index + 1}-Private${count.index + 1}"
    subnet_id                     = "${element(azurerm_subnet.private_subnets.*.id,count.index)}"
    private_ip_address_allocation = "Dynamic"
  }
}

###############################
#pfSense VPN Appliance
###############################

#pfSense Server
resource "azurerm_virtual_machine" "pfSense" {
  name                             = "C${var.region_code["${var.region}"]}LAPFSENSE0${count.index + 1}P"
  location                         = "${var.region}"
  resource_group_name              = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids            = ["${element(azurerm_network_interface.pfSense.*.id,count.index)}"]
  vm_size                          = "${var.pfsense_size_map["${var.region}"]}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  plan {
    name      = "netgate-pfsense-azure-243"
    publisher = "netgate"
    product   = "netgate-pfsense-azure-fw-vpn-router"
  }

  storage_image_reference {
    publisher = "netgate"
    offer     = "netgate-pfsense-azure-fw-vpn-router"
    sku       = "netgate-pfsense-azure-243"
    version   = "latest"
  }

  storage_os_disk {
    name              = "pfSense${count.index + 1}-rootvol"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "C${var.region_code["${var.region}"]}LAPFSENSE0${count.index + 1}P"
    admin_username = "csiadmin"
    admin_password = "${var.pfsense_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

#pfSense Server Private Network Interface
resource "azurerm_network_interface" "pfSense" {
  name                 = "pfSense-NIC${count.index + 1}"
  location             = "${var.region}"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "pfSense"
    subnet_id                     = "${element(azurerm_subnet.gateway_subnet.*.id,count.index)}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pfSense_public.id}"
  }
}

#pfSense Server Public IP
resource "azurerm_public_ip" "pfSense_public" {
  name                = "pfSense-Public${count.index + 1}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Static"
}
