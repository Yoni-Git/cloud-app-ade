variable "github_repo" {
  description = "The GitHub repository"
  type        = string
}

variable "codecommit_repo" {
  description = "The CodeCommit repository"
  type        = string
}

variable "github_token" {
  description = "The GitHub personal access token"
  type        = string
}

variable "github_org" {
  description = "The name of the GitHub organization"
  type        = string
}

variable "repository_clone_url_http" {
  description = "The HTTP URL to clone the repository"
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
