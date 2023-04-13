# DB SUBNET GROUP
resource "aws_db_subnet_group" "db-sbg" {
  name         = "${var.db_name}-db-private-subnet-group" 
                 
  subnet_ids   = [ var.vpc_private_subnet_01, var.vpc_private_subnet_02 ]
  description  = "RDS DB Subnet Group"

}
