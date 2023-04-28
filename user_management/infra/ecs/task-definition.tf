resource "aws_ecs_task_definition" "app_task" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name      = "app-container"
      image     = "${var.registry_url}:${var.image_tag}"
      memory    = 1024
      cpu       = 512
      essential = true
    }
  ])
}
