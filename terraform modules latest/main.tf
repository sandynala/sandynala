terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    access_key= ""
    secret_key= ""
    region = "us-east-1"
}


module "test_vpc" {
  source = "./Modules/VPC"
vpc_cidr = "10.0.0.0/16"
vpc_name = "Test_VPC"
public_cidrs = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
private_cidrs = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
azs = ["us-east-1a","us-east-1b","us-east-1c"] 
}

module "testweb" {
  source = "./Modules/EC2"
ami = "ami-0e472ba40eb589f49"
machinecount = "3"
instancetype = "t2.micro"
public_subnets = "${module.test_vpc.publicsubnetids}"
sgid = "${module.test_vpc.sgid}"
keyname = "virginia"
}
