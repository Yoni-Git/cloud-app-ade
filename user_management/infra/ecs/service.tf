resource "aws_ecs_service" "app_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = var.desired_count

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups = [aws_security_group.app_sg.id]
    subnets         = var.subnets
    assign_public_ip = true
  }

  depends_on = [aws_security_group_rule.app_sg_ingress]
}

resource "aws_security_group" "app_sg" {
  name_prefix = "app-"
  vpc_id      = var.vpc_id

  ingress {
    from_port = var.container_port
    to_port   = var.container_port
    protocol  = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_lb_sg" {
  name_prefix = "app-lb-sg-"

  ingress {
    from_port = var.lb_port
    to_port   = var.lb_port
    protocol  = "tcp"
    cidr_blocks = var.lb_cidr_blocks
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-lb-sg"
  }
}

resource "aws_security_group_rule" "app_sg_ingress" {
  type        = "ingress"
  from_port   = var.container_port
  to_port     = var.container_port
  protocol    = "tcp"
  security_group_id = aws_security_group.app_sg.id
  source_security_group_id = aws_security_group.app_lb_sg.id
}
