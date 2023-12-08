#Azure VNET
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}-${var.region}"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-${var.region}"
  location            = "${var.region}"
  address_space       = ["${var.cidr}"]
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  dns_servers         = ["${var.rodc_private_ip}", "10.1.2.210"]
  tags                = "${merge(map("Name", format("%s", "${var.name}-VNET")), var.tags)}"
}

resource "azurerm_subnet" "private_subnets" {
  name                      = "${var.private_subnet_names[count.index]}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  address_prefix            = "${var.private_subnet_prefixes[count.index]}"
  count                     = "${length(var.private_subnet_names)}"
  route_table_id            = "${azurerm_route_table.Private.id}"
  network_security_group_id = "${azurerm_network_security_group.Private.id}"
}

resource "azurerm_subnet" "public_subnets" {
  name                      = "${var.public_subnet_names[count.index]}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  address_prefix            = "${var.public_subnet_prefixes[count.index]}"
  count                     = "${length(var.public_subnet_names)}"
  route_table_id            = "${azurerm_route_table.Public.id}"
  network_security_group_id = "${azurerm_network_security_group.Public.id}"
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "Gateway-Subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  address_prefix       = "${var.gateway_subnet_cidr}"
}
