#Public Route Table
resource "azurerm_route_table" "Public" {
  name                          = "Public"
  location                      = "${var.region}"
  resource_group_name           = "${azurerm_resource_group.resource_group.name}"
  disable_bgp_route_propagation = false

  route {
    name                   = "HQ"
    address_prefix         = "172.20.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "SCDC"
    address_prefix         = "10.1.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "Old_SCDC"
    address_prefix         = "172.16.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "New_SCDC"
    address_prefix         = "10.0.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }
}

#Public Route Table Association
resource "azurerm_subnet_route_table_association" "Public" {
  count          = "${length(var.public_subnet_names)}"
  subnet_id      = "${element(azurerm_subnet.public_subnets.*.id,count.index)}"
  route_table_id = "${azurerm_route_table.Public.id}"
}

#Private Route Table
resource "azurerm_route_table" "Private" {
  name                          = "Private"
  location                      = "${var.region}"
  resource_group_name           = "${azurerm_resource_group.resource_group.name}"
  disable_bgp_route_propagation = false

  route {
    name                   = "HQ"
    address_prefix         = "172.20.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "SCDC"
    address_prefix         = "10.1.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "Old_SCDC"
    address_prefix         = "172.16.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }

  route {
    name                   = "New_SCDC"
    address_prefix         = "10.0.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "${azurerm_network_interface.pfSense.private_ip_address}"
  }
}

#Private Route Table Association
resource "azurerm_subnet_route_table_association" "Private" {
  count          = "${length(var.private_subnet_names)}"
  subnet_id      = "${element(azurerm_subnet.private_subnets.*.id,count.index)}"
  route_table_id = "${azurerm_route_table.Private.id}"
}
