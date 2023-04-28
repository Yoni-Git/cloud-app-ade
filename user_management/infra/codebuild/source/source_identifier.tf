resource "aws_codebuild_source_credential" "app_credential" {
  server_type = "GITHUB"
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  token       = var.github_token
}

data "github_repository" "app_repo" {
  name = var.github_repo
}

data "aws_codecommit_repository" "app_repo" {
  repository_name = var.codecommit_repo
}

data "aws_region" "current" {}

resource "aws_codebuild_source" "app_source" {
  type                  = "GITHUB"
  buildspec             = "codebuild/source/buildspec.yml"
  report_build_status   = true
  location              = data.github_repository.app_repo.clone_url
  git_clone_depth       = 1
  insecure_ssl          = false

  environment_variables = [
    {
      name  = "AWS_DEFAULT_REGION"
      value = data.aws_region.current.name
    },
    {
      name  = "ECR_REGISTRY"
      value = var.ecr_registry_url
    },
    {
      name  = "ECR_REPOSITORY"
      value = var.ecr_repository_name
    },
    {
      name  = "IMAGE_TAG"
      value = var.image_tag
    },
    {
      name  = "APP_JAR_NAME"
      value = var.app_jar_name
    }
  ]

  auth {
    type     = "OAUTH"
    resource = aws_codebuild_source_credential.app_credential.arn
  }
}

