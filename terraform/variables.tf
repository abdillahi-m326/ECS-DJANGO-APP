variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default = {
    Environment = "Django-ecs-app"
    Owner       = "Django-app"
  }
}

variable "name_prefix" {
  description = "Prefix for naming all resources"
  type        = string
  default     = "Django-app"
}