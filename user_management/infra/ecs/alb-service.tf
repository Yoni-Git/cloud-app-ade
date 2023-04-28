resource "aws_alb" "app_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb_target_group" "app_tg" {
  name_prefix      = "app-"
  port             = var.target_group_port
  protocol         = "HTTP"
  vpc_id           = var.vpc_id
  target_type      = "ip"
  health_check {
    interval            = 30
    path                = var.path_pattern
    port                = var.target_group_port
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_ecs_cluster" "app_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_service" "app_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    security_groups = [aws_security_group.ecs_service_sg.id]
    subnets         = var.subnets
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.app_tg.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = var.task_family
  container_definitions    = data.template_file.app_container_definition.rendered
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
}

data "template_file" "app_container_definition" {
  template = file("${path.module}/container-definition.json.tpl")

  vars = {
    image_tag = var.image_tag
  }
}

resource "aws_security_group" "ecs_service_sg" {
  name_prefix = "ecs-service-"
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.container_port
    to_port   = var.container_port
    protocol  = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

