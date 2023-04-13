module "rds" {
    source  = "terraform-aws-modules/rds/aws"
    version = "5.1.0"
  
    identifier = "${var.db_name}-rds"
    engine     = "postgres"
    engine_version = "14.1"  
    family     = "postgres14"
    major_engine_version = "14"  
    instance_class       = "db.t3.small"

    storage_type          = "gp2"
    allocated_storage     = 20
    max_allocated_storage = 1000
    storage_encrypted = false
    create_db_option_group = false
    create_db_parameter_group = false
    backup_retention_period = 0

    username = var.db_username
    db_name = var.db_name
    create_random_password = true
    random_password_length = 12
    port     = 5432
    subnet_ids = [ aws_db_subnet_group.db-sbg.id ]
    vpc_security_group_ids = [ module.security_group.security_group_id ]
    db_subnet_group_name = aws_db_subnet_group.db-sbg.name
    publicly_accessible = false
    deletion_protection = false

    maintenance_window              = "Mon:00:00-Mon:03:00"
    backup_window                   = "03:00-06:00"   
    copy_tags_to_snapshot           = true

}

# SAVE DATA AND PASSWORD
resource "random_id" "id" {
  byte_length = 8
}

resource "aws_secretsmanager_secret" "db-pass" {
  name = "${var.db_name}-rds-credentials-${random_id.id.hex}"
}

resource "aws_secretsmanager_secret_version" "db-pass-val" {
  secret_id = aws_secretsmanager_secret.db-pass.id
  secret_string = jsonencode(
    {
      username = var.db_username
      password = module.rds.db_instance_password
      engine   = "postgresql"
      host     = module.rds.db_instance_endpoint
    }
  )
}
