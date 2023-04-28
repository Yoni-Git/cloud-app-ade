variable "aws_region" {
  description = "The AWS region where resources will be created"
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

variable "project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "environment" {
  description = "The environment for the resources being created"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be created"
  type        = string
}

variable "subnets" {
  description = "The list of subnet IDs where resources will be created"
  type        = list(string)
}

variable "lb_name" {
  description = "The name of the application load balancer"
  type        = string
}

variable "lb_type" {
  description = "The type of the application load balancer"
  type        = string
  default     = "application"
}

variable "lb_port" {
  description = "The port on which the load balancer will listen"
  type        = number
  default     = 80
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which the target group will listen"
  type        = number
  default     = 8080
}

variable "path_pattern" {
  description = "The HTTP path pattern for the health check"
  type        = string
  default     = "/health"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "The desired number of tasks to run in the ECS service"
  type        = number
  default     = 1
}

variable "container_name" {
  description = "The name of the container in the ECS task definition"
  type        = string
}

variable "container_port" {
  description = "The port on which the container will listen"
  type        = number
  default     = 8080
}

variable "image_tag" {
  description = "The tag of the Docker image to deploy"
  type        = string
}

variable "task_family" {
  description = "The family name of the ECS task definition"
  type        = string
}
variable "lb_cidr_blocks" {
  description = "CIDR blocks for ALB security group ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "registry_url" {
  description = "The URL of the ECR repository to deploy to"
  type        = string
}
variable "zone_id" {
  description = "The ID of the Route 53 hosted zone to create the record in"
}

variable "dns_name" {
  description = "The domain name for the Route 53 record"
}
