resource "aws_ecr_repository" "rearc_quest" {
  name = "${var.prefix}_quest" 
}
