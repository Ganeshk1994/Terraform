#Specify the region
region = "southafricanorth"
#Name to be used on all the resources as identifier
name = "Management"
#Specify the VNEt CIDR
cidr = "10.28.0.0/22"
#Specify the Names and CIDRs of each private subnet
private_subnet_names = ["Private-1", "Private-2"]
private_subnet_prefixes = ["10.28.0.0/24","10.28.1.0/24"]
#Specify the Names and CIDRs of each public subnet
public_subnet_names = ["Public-1", "Public-2"]
public_subnet_prefixes = ["10.28.2.0/25","10.28.2.128/25"]
#Specify the Gateway Subnets for the VPN appliance
gateway_subnet_cidr = "10.28.3.0/28"
#RD-Gateway Server Variables
instance_type = "Standard_B2MS"
rdgw_password = "8c9[#S.D}HCPgTr-"
#Domain Controller Server Variables
domain_controller_instance_type = "Standard_B2S"
domain_controller_password = "c48^8ER5$pT;zPXr"
#pfSense Variables
pfsense_password = "S9ADxDM6MQa~S=HM"
#DNS Server Address.  Specify the Private IP address of the read only domain controller in the region after it has been deployed.  Until it is deployed, use 10.1.2.211
rodc_private_ip = "10.28.0.4"
#Tags that are applied to all resources
tags = {

    Customer = "CentricSoftware"
    Terraform = "True"
    Environment = "Management"
    "Role" = "Management"
    Owner = "cloudops@centricsoftware.com"
    "Business Unit" = "IT"    
}