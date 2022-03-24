##################################################################################
# DATA
##################################################################################

data "aws_elb_service_account" "root" {}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_lb" "nginx" {
  name               = "globo-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.s3_bucket.bucket.bucket
    prefix  = "alb-logs"
    enabled = true
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-elb"
  })
}

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-tg"
  })
}

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-listener"
  })
}

resource "aws_lb_target_group_attachment" "nginxs" {
  count            = var.instance_nginx_count
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginxs[count.index].id
  port             = 80
}
