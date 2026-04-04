resource "aws_lb_target_group" "django_app_alb" {
  name     = "django-app-alb"
  target_type = "ip"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
  path                = "/"
  protocol            = "HTTP"
  matcher             = "200"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

}