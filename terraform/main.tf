provider "aws" {
  region = var.region
  shared_credentials_file = "~/.aws.credentials"
}

module "my-vpc" {
  source = "./VPC"
}

module "my-ec2" {
  source = "./EC2"
  vpc-id = module.my-vpc.vpcid
  subnet_a_id = module.my-vpc.subnetid
}

module "my-rds" {
  source = "./RDS"
  vpc-id = module.my-vpc.vpcid
  private_db_subnet = module.my-vpc.privatesubnetid
}




