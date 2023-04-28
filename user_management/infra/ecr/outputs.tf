output "registry_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.app_repo.name
}

output "ecr_registry_id" {
  value = data.aws_caller_identity.current.account_id
}
