resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/django-ecs-app"
  retention_in_days = 7
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "Django-ecs-app-cluster"
}
resource "aws_ecs_task_definition" "django_app_task" {
  family                   = "django_app_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode(
    [{
      container_name   = "django-ecs-app"
      image            = "210678020643.dkr.ecr.us-east-1.amazonaws.com/django-ecs-app-repo:v1"
      essential        = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
            options = {
                awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
                awslogs-region        = "us-east-1"
                awslogs-stream-prefix = "ecs"
            }
         }
    } 
  ])
}

resource "aws_ecs_service" "django_service" {
  name            = "django_service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.django_app_task.arn
  desired_count   = 1
  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = aws_lb_target_group.django_app_alb.arn
    container_name   = "django-ecs-app"
    container_port   = 8000
  }

  network_configuration {
  subnets          = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  security_groups  = [aws_security_group.ecs_sg.id]
  assign_public_ip = false
}


depends_on = [aws_lb_listener.http_forward]

}

