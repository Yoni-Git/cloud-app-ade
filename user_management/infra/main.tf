provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source = "./ecr"
  aws_region = var.aws_region
  repo_name  = var.repo_name
}


module "ecs" {
  source = "./ecs"

  cluster_name      = var.cluster_name
  task_family       = var.task_family
  service_name      = var.service_name
  desired_count     = var.desired_count
  image_tag         = var.image_tag
  subnets           = var.subnets
  lb_name           = var.lb_name
  lb_type           = var.lb_type
  lb_port           = var.lb_port
  target_group_name = var.target_group_name
  target_group_port = var.target_group_port
  path_pattern      = var.path_pattern
  vpc_id            = var.vpc_id
  zone_id           = var.zone_id
  dns_name          = var.dns_name
  aws_region        = var.aws_region
  container_name    = var.container_name
  github_org        = var.github_org
  project_name      = var.project_name
  repo_name         = var.repo_name
  app_sg_id         = aws_security_group.app_sg.id
  alb_sg_id         = aws_security_group.app_lb_sg.id
  repository_clone_url_http = var.repository_clone_url_http
  repository_url            = module.ecr.registry_url
}


module "dynamodb" {
  source = "./dynamodb"

  table_name = var.table_name
  hash_key   = var.hash_key
}

module "codebuild" {
  source = "./codebuild"

  project_name     = var.project_name
  source_location  = var.source_location
  environment      = var.environment
  github_org       = var.github_org
  github_repo      = var.github_repo
  codecommit_repo  = var.codecommit_repo
  github_token     = var.github_token
  # Use the registry_url output of the ecr module
  ecr_registry_url  = module.ecr.registry_url
  ecr_repository_name = module.ecr.repository_name
  app_jar_name = var.app_jar_name
  image_tag =  var.image_tag


}

resource "aws_security_group" "app_lb_sg" {
  name_prefix = "app-lb-"
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.lb_port
    to_port   = var.lb_port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name_prefix = "app-"
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.container_port
    to_port   = var.container_port
    protocol  = "tcp"
    security_groups = [aws_security_group.app_lb_sg.id]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "app_url" {
  value = module.ecs.app_url
}
