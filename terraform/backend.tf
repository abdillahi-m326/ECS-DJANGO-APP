terraform {
  backend "s3" {
    bucket = "my-terraform-tfstate-django-ecs-app"
    key    = "ecs-fargate/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "django-ecs-locks"
  }
}