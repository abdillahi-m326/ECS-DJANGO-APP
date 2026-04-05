variable "aws_region" {
  type        = string
  description = "AWS region for the backend resources"
  default     = "us-east-1"
}

variable "state_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for Terraform state"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for Terraform state locking"
  default     = "django-ecs-locks"
}

variable "tags" {
  type        = map(string)
  description = "Tags for bootstrap resources"
  default     = {}
}

variable "ecr_repo_name" {
  type        = string
  description = "Repository for the app"
  default     = "django-ecs-app-repo"
}