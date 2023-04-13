# LOCAL VARIABLES #
locals {
  # PROVIDER CONFIG
  aws_name_profile = "aaaimx-aws"
  aws_region = "us-west-1"

  # vpc variables 
  vpc_cidr = "10.20.0.0/20"
  vpc_public_subnet_01 = "10.20.0.0/23"
  vpc_public_subnet_02 = "10.20.2.0/23"
  vpc_private_subnet_01 = "10.20.8.0/23"
  vpc_private_subnet_02 = "10.20.10.0/23"

  # config vars
  db_name       =  "aaaimxwater"
  db_username   = "aaaimxwater_user"
  instance_name = "aaaimx-water"
}
