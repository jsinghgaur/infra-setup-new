
# calling vpc module
module "dev-vpc" {
  source                  = "../../modules/vpc"
  region                  = "ap-south-1"
  project_name            = var.my_project_name
  environment             = "devlopment"
  vpc_cidr                = "10.10.0.0/16"
  enable_dns_hostnames    = true
  enable_dns_support      = true
  public_subnet_az1_cidr  = "10.10.1.0/24"
  public_subnet_az2_cidr  = "10.10.2.0/24"
  public_subnet_az3_cidr  = "10.10.3.0/24"
  private_subnet_az1_cidr = "10.10.4.0/24"
  private_subnet_az2_cidr = "10.10.5.0/24"
  private_subnet_az3_cidr = "10.10.6.0/24"
  Date_of_Creation        = "13/03/2024"
}