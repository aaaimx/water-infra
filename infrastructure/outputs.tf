output "ecr_repo_url" {
    description = "Primary endpoint of the elastic container registry"
    value       = try(module.ecr.ecr_repo_url, "")
}

output "secrets_manager" {
    description = "ARN for RDS postgres database"
    value       = try(module.rds.rds_secret_credentials, "")
}

output "dns_name" {
    description = "dns name of the loadbalancer elastic container service"
    value       = try(module.ecs.dns_name, "")
}