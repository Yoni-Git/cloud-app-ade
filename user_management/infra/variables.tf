variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "zone_id" {
  description = "The ID of the Route53 hosted zone"
  type        = string
}

variable "dns_name" {
  description = "The DNS name of the application"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "users"
}

variable "hash_key" {
  description = "The name of the hash key"
  type        = string
}

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

variable "github_org" {
  description = "The GitHub organization"
  type        = string
}

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
variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "The name of the ECS task family"
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired number of tasks to run"
  type        = number
}

variable "subnets" {
  description = "The list of subnets to use"
  type        = list(string)
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "lb_type" {
  description = "The type of the load balancer"
  type        = string
}

variable "lb_port" {
  description = "The port of the load balancer listener"
  type        = number
}
variable "lb_cidr_blocks" {
  description = "A list of CIDR blocks to allow traffic from for the application load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port of the target group"
  type        = number
}

variable "path_pattern" {
  description = "The path pattern to match"
  type        = string
}

variable "container_port" {
  description = "The port on which the container will listen"
  type        = number
  default     = 8080
}

variable "container_name" {
  description = "The name of the container in the ECS task definition"
  type        = string
}

variable "repo_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag" {
  description = "The tag of the Docker image to build and deploy"
  default     = "latest"
}
variable "app_jar_name" {
  description = "The name of the Spring Boot application jar file"
  default     = "api.jar"
}
variable "repository_clone_url_http" {
  description = "The name of the Spring Boot application jar file"
  type        = string
}
