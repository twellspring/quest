variable "ecs_memory" {
  type = number
  description = "Memory for ECS"
  default = 512
}

variable "ecs_cpu" {
  type = number
  description = "CPU for ECS"
  default = 256
}

variable "region" {
  type = string
  default = "us-west-2"
}

variable "prefix" {
  type = string
  description = "prefix for AWS resources"
  default = "rearc"
}

variable "vpc_cidr" {
    type = string
    default = "10.10.0.0/16"
}