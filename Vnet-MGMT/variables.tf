variable "region" {
  description = "The region in which resources will be deployed"
  default     = ""
}

variable "name" {
  description = "The name given to various resources"
  default     = ""
}

variable "cidr" {
  description = "The address space of the VNET"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "private_subnet_names" {
  description = "A list of the subnet names"
  type        = "list"
  default     = [""]
}

variable "private_subnet_prefixes" {
  description = "The subnet IP ranges"
  type        = "list"
  default     = [""]
}

variable "public_subnet_names" {
  description = "A list of the subnet names"
  type        = "list"
  default     = [""]
}

variable "public_subnet_prefixes" {
  description = "The subnet IP ranges"
  type        = "list"
  default     = [""]
}

variable "domain_controller_instance_type" {
  description = "The instance type or size of the server"
}

variable "domain_controller_password" {
  description = "The password to the Domain Controller server"
}

variable "instance_type" {
  description = "The instance type or size of the server"
}

variable "rdgw_password" {
  description = "The password to the RD-Gateway server"
}

variable "pfsense_password" {
  description = "The password to the pfSense appliance"
}

variable "pfsense_size_map" {
  type = "map"

  default = {
    "francecentral"      = "Standard_A1"
    "brazilsouth"        = "Basic_A1"
    "westus"             = "Standard_A1"
    "westus2"            = "Standard_A1"
    "eastasia"           = "Standard_A1"
    "southeastasia"      = "Standard_A1"
    "centralus"          = "Standard_A1"
    "eastus"             = "Standard_A1"
    "eastus2"            = "Standard_A1"
    "northcentralus"     = "Standard_A1"
    "southcentralus"     = "Standard_A1"
    "northeurope"        = "Standard_A1"
    "westeurope"         = "Standard_A1"
    "japanwest"          = "Standard_A1"
    "japaneast"          = "Standard_A1"
    "australiaeast"      = "Standard_A1"
    "australiasoutheast" = "Standard_A1"
    "southindia"         = "Standard_A1"
    "centralindia"       = "Standard_A1"
    "westindia"          = "Standard_A1"
    "canadacentral"      = "Standard_A1"
    "canadaeast"         = "Standard_A1"
    "uksouth"            = "Standard_D1_v2"
    "ukwest"             = "Standard_A1"
    "westcentralus"      = "Standard_A1"
    "koreacentral"       = "Standard_A1"
    "koreasouth"         = "Standard_A1"
    "francesouth"        = "Standard_A1"
    "australiacentral"   = "Standard_A1"
    "australiacentral2"  = "Standard_A1"
    "uaecentral"         = "Standard_A1"
    "uaenorth"           = "Standard_A1"
    "southafricanorth"   = "Standard_B1ms"
    "southafricawest"    = "Standard_A1"
  }
}

variable "region_code" {
  type = "map"

  default = {
    "francecentral"      = "20"
    "brazilsouth"        = "21"
    "westus"             = "22"
    "westus2"            = "23"
    "eastasia"           = "24"
    "southeastasia"      = "25"
    "centralus"          = "26"
    "eastus"             = "27"
    "eastus2"            = "28"
    "northcentralus"     = "29"
    "southcentralus"     = "30"
    "northeurope"        = "31"
    "westeurope"         = "32"
    "japanwest"          = "33"
    "japaneast"          = "34"
    "australiaeast"      = "35"
    "australiasoutheast" = "36"
    "southindia"         = "37"
    "centralindia"       = "38"
    "westindia"          = "39"
    "canadacentral"      = "40"
    "canadaeast"         = "41"
    "uksouth"            = "42"
    "ukwest"             = "43"
    "westcentralus"      = "44"
    "koreacentral"       = "45"
    "koreasouth"         = "46"
    "francesouth"        = "47"
    "australiacentral"   = "48"
    "australiacentral2"  = "49"
    "uaecentral"         = "50"
    "uaenorth"           = "51"
    "southafricanorth"   = "52"
    "southafricawest"    = "53"
  }
}

variable "gateway_subnet_cidr" {
  description = "The CIDR of the Gateway Subnet"
}

variable "rodc_private_ip" {
  description = "The Private IP address of the Read Only Domain Controller in the region"
}
