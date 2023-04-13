output "rds_secret_credentials" {

  value = aws_secretsmanager_secret.db-pass.name
  
}