variable "project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "source_location" {
  description = "The location of the source code repository"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "codecommit_repo" {
  description = "The name of the CodeCommit repository"
  type        = string
}

variable "ecr_registry_url" {
  type = string
}

variable "ecr_repository_name" {
  type = string
}
variable "image_tag" {
  description = "The tag of the Docker image to build and deploy"
}

variable "app_jar_name" {
  description = "The name of the Spring Boot application jar file"
}

