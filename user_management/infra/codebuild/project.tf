data "aws_codecommit_repository" "app_repo" {
  repository_name = var.codecommit_repo
}

resource "aws_codebuild_project" "app_build" {
  name                    = var.project_name
  description             = "CodeBuild project to build the Spring Boot application"
  service_role            = aws_iam_role.app_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
    environment_variables = [
      {
        name  = "JAVA_HOME"
        value = "/usr/lib/jvm/java-11-amazon-corretto"
      },
      {
        name  = "MAVEN_HOME"
        value = "/usr/share/maven"
      }
    ]
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.app_repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "codebuild/source/buildspec.yml"
    ecr_registry_url = var.ecr_registry_url
  }
  build_timeout = 60
  tags = {
    Environment = var.environment
  }
}
