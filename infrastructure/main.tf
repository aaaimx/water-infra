# --- VPC - MODULE --- #
module "vpc" {
    source = "../modules/vpc"

    # vpc tags
    aws_region = local.aws_region
    vpc_cidr = local.vpc_cidr
    vpc_public_subnet_01 = local.vpc_public_subnet_01
    vpc_public_subnet_02 = local.vpc_public_subnet_02
    vpc_private_subnet_01 = local.vpc_private_subnet_01
    vpc_private_subnet_02 = local.vpc_private_subnet_02
}

# --- ECR - using pipeline to build image with gitlab-ci
module "ecr" {
    source = "../modules/ecr"

    repository_name = "aaaimx-ecr"
}

module "rds" {
    source                 = "../modules/rds"

    db_name                = local.db_name
    db_username            = local.db_username
    vpc_id                 = module.vpc.vpc_id
    vpc_cidr_block         = module.vpc.cidr_block
    vpc_private_subnet_01  = module.vpc.private_subnet_01_id
    vpc_private_subnet_02  = module.vpc.private_subnet_02_id
}
# MODULO PARA ECS - crear una task definition
module "ecs" {
  source = "../modules/ecs"

  cluster_name   = "aaaimx-water-cluster"
  subnet_ids = [ module.vpc.public_subnet_01_id , module.vpc.public_subnet_02_id ]
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = local.vpc_cidr
  
}

