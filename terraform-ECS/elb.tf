resource "aws_lb" "quest" {
  name               = "${var.prefix}-quest"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_target_group" "quest" {
  name        = "${var.prefix}-quest"
  port        = "3000"
  protocol    = "HTTP"
  vpc_id      =  module.vpc.vpc_id
  target_type = "ip"
  health_check {
    interval = 30
    port     = 3000
    path     = "/aws"
    protocol = "HTTP"
    timeout  = 28
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.quest.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.quest.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.quest.arn

  default_action {
    target_group_arn = aws_lb_target_group.quest.arn
    type             = "forward"
  }
}

resource "aws_acm_certificate" "quest" {
  private_key       = var.tls_key
  certificate_body  = var.tls_certificate
  certificate_chain = var.tls_chain
}