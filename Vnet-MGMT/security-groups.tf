#Private Network Security Group
resource "azurerm_network_security_group" "Private" {
  name                = "Private"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_network_security_rule" "Deny_All_From_Internet" {
  name                        = "Deny All From Internet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Private.name}"
}

resource "azurerm_network_security_rule" "Allow_All_From_On_Prem_Private" {
  name                        = "Allow All From On Prem"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["10.0.0.0/16", "10.1.0.0/16", "172.16.0.0/16", "172.20.0.0/16"]
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Private.name}"
}

resource "azurerm_network_security_rule" "Allow_All_To_On_Prem" {
  name                         = "Allow All To On Prem"
  priority                     = 120
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefix        = "*"
  destination_address_prefixes = ["10.0.0.0/16", "10.1.0.0/16", "172.16.0.0/16", "172.20.0.0/16"]
  resource_group_name          = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name  = "${azurerm_network_security_group.Private.name}"
}

#Private Network Security Group Association
resource "azurerm_subnet_network_security_group_association" "Private" {
  count                     = "${length(var.private_subnet_names)}"
  subnet_id                 = "${element(azurerm_subnet.private_subnets.*.id,count.index)}"
  network_security_group_id = "${azurerm_network_security_group.Private.id}"
}

#Public Network Security Group
resource "azurerm_network_security_group" "Public" {
  name                = "Public"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_network_security_rule" "Allow_Web_From_Internet" {
  name                        = "Allow Web Traffic From Internet"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Public.name}"
}

resource "azurerm_network_security_rule" "Allow_RDP_From_Internet" {
  name                        = "Allow RDP Traffic From Internet"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Public.name}"
}

resource "azurerm_network_security_rule" "Allow_IPSEC_From_SCDC" {
  name                        = "Allow IPSEC Traffic From SCDC"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["500", "50-51"]
  source_address_prefix       = "198.35.53.174/32"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Public.name}"
}

resource "azurerm_network_security_rule" "Allow_All_From_On_Prem_Public" {
  name                        = "Allow All From On Prem"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["10.0.0.0/16", "10.1.0.0/16", "172.16.0.0/16", "172.20.0.0/16"]
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Public.name}"
}

resource "azurerm_network_security_rule" "Allow_All_To_On_Prem_Outbound" {
  name                         = "Allow All To On Prem"
  priority                     = 100
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefix        = "*"
  destination_address_prefixes = ["10.0.0.0/16", "10.1.0.0/16", "172.16.0.0/16", "172.20.0.0/16"]
  resource_group_name          = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name  = "${azurerm_network_security_group.Public.name}"
}

resource "azurerm_network_security_rule" "Allow_IPSEC_To_SCDC" {
  name                        = "Allow IPSEC Traffic To SCDC"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["500", "50-51"]
  source_address_prefix       = "*"
  destination_address_prefix  = "198.35.53.174/32"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  network_security_group_name = "${azurerm_network_security_group.Public.name}"
}

#Public Network Security Group Association
resource "azurerm_subnet_network_security_group_association" "Public" {
  count                     = "${length(var.public_subnet_names)}"
  subnet_id                 = "${element(azurerm_subnet.public_subnets.*.id,count.index)}"
  network_security_group_id = "${azurerm_network_security_group.Public.id}"
}
