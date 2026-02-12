# ---------------------------
# Application Load Balancer
# ---------------------------

resource "aws_lb" "app" {
  name               = "dev-3tier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = merge(local.common_tags, {
    Name = "dev-3tier-alb"
  })
}

# ---------------------------
# Target Group
# ---------------------------

resource "aws_lb_target_group" "app" {
  name     = "dev-3tier-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(local.common_tags, {
    Name = "dev-3tier-tg"
  })
}

# ---------------------------
# Listener
# ---------------------------

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# ---------------------------
# Target Attachment
# ---------------------------

resource "aws_lb_target_group_attachment" "backend" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = aws_instance.backend.id
  port             = 80
}

