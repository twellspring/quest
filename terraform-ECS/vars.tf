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

variable "secret_word" {
  type = string
  description = "the secret word"
  default = "418 I'm a teapot"
  sensitive = true
}

variable "tls_certificate" {
  type = string
  description = "prefix for AWS resources"
  default = ""
  sensitive = true
}

variable "tls_key" {
  type = string
  description = "TLS private key"
  default = ""
  sensitive = true
}

variable "tls_chain" {
  type = string
  description = "TLS Chain / CA Bundle"
  default = ""
  sensitive = true
}


variable "vpc_cidr" {
    type = string
    default = "10.10.0.0/16"
}