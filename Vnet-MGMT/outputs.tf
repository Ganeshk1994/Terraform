output "private_subnet_names" {
  value = "${var.private_subnet_names}"
}

output "private_subnet_prefixes" {
  value = "${var.private_subnet_prefixes}"
}

output "public_subnet_names" {
  value = "${var.public_subnet_names}"
}

output "public_subnet_prefixes" {
  value = "${var.public_subnet_prefixes}"
}

output "cidr" {
  value = "${var.cidr}"
}

output "name" {
  value = "${var.name}"
}

output "private_route_tables" {
  value = "${azurerm_route_table.Private.*.id}"
}

output "private_route_table_names" {
  value = "${azurerm_route_table.Private.*.name}"
}

output "public_route_tables" {
  value = "${azurerm_route_table.Public.*.id}"
}

output "public_route_table_names" {
  value = "${azurerm_route_table.Public.*.name}"
}

output "private_security_group" {
  value = "${azurerm_network_security_group.Private.*.id}"
}

output "public_security_group" {
  value = "${azurerm_network_security_group.Public.*.id}"
}

output "vnet" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "vnet_name" {
  value = "${azurerm_virtual_network.vnet.name}"
}

output "resource_group" {
  value = "${azurerm_resource_group.resource_group.name}"
}

output "RDGW_public_ip_address" {
  value = "${azurerm_public_ip.RDGW_Public.ip_address}"
}

output "pfSense_public_ip_address" {
  value = "${azurerm_public_ip.pfSense_public.ip_address}"
}

output "pfSense_private_ip_address" {
  value = "${azurerm_network_interface.pfSense.private_ip_address}"
}

output "gateway_subnet_cidr" {
  value = "${var.gateway_subnet_cidr}"
}
