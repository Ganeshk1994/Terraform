#Specify the region
region = "francecentral"
#Name to be used on all the resources as identifier
name = "Management"
#Specify the VNEt CIDR
cidr = "10.25.0.0/22"
#Specify the Names and CIDRs of each private subnet
private_subnet_names = ["Private-1", "Private-2"]
private_subnet_prefixes = ["10.25.0.0/24","10.25.1.0/24"]
#Specify the Names and CIDRs of each public subnet
public_subnet_names = ["Public-1", "Public-2"]
public_subnet_prefixes = ["10.25.2.0/25","10.25.2.128/25"]
#Specify the Gateway Subnets for the VPN appliance
gateway_subnet_cidr = "10.25.3.0/28"
#RD-Gateway Server Variables
instance_type = "Standard_B2MS"
rdgw_password = "Y2vbxNpeTvj4gLms"
#Domain Controller Server Variables
domain_controller_instance_type = "Standard_B2S"
domain_controller_password = "HtGQXyNVm2CZyx52"
#pfSense Variables
pfsense_password = "CHWb8nuvzFHuAPt4"
#DNS Server Address.  Specify the Private IP address of the read only domain controller in the region after it has been deployed.  Until it is deployed, use 10.1.2.211
rodc_private_ip = "10.1.2.211"
#Tags that are applied to all resources
tags = {

    Customer = "CentricSoftware"
    Terraform = "True"
    Environment = "Management"
    "Role" = "Management"
    Owner = "cloudops@centricsoftware.com"
    "Business Unit" = "IT"    
}