############################################
#Terraform Backend Configuration
############################################

terraform {
  required_version = "~> 0.11.0"

  #UPDATE "KEY" ARGUMENT TO POINT TO NEW PATH 
  backend "s3" {
    encrypt      = true
    session_name = "Terraform"
    bucket       = "terraform-state-364212806617"

    key            = "AZURE/IT/Regional/VNET-MGMT/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    role_arn       = "arn:aws:iam::364212806617:role/Terraform"
    region         = "us-west-1"
  }
}
