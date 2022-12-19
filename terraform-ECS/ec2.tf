
resource "aws_security_group" "quest" {
  name        = "${var.prefix}_ingress"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.vpc_id
}


resource "aws_security_group_rule" "http_ingress" {
  security_group_id = aws_security_group.quest.id
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]  
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.quest.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]  
}