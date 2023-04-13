module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.db_name}-sg-db"
  description = "RDS security group"
  vpc_id      = var.vpc_id
  egress_rules = ["all-all"]

  ingress_with_cidr_blocks = [
                              {
                                from_port   = 5432
                                to_port     = 5432
                                protocol    = "tcp"
                                description = "containers ports"
                                cidr_blocks = var.vpc_cidr_block
                              },
                            ]
}
