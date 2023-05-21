data "aws_ami" "last_img" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["flask-app-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# output "last_img" {
#   value = data.aws_ami.last_img.id
# }

resource "aws_launch_template" "flask_app" {
  name                   = "flask_app"
  image_id               = data.aws_ami.last_img.id
  key_name               = "devops"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  update_default_version = true
  monitoring {
    enabled = true
  }
  tags = {
    name        = "test-template"
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "app"
  port     = 8080
  protocol = var.network_protocols[1]
  vpc_id   = data.aws_vpc.dev-vpc.id

  health_check {
    enabled             = true
    port                = 8081
    interval            = 30
    protocol            = var.network_protocols[1]
    path                = "/health"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# resource "aws_autoscaling_group" "app" {
#   name     = "app"
#   min_size = 1
#   max_size = 3

#   health_check_type = "EC2"

#   vpc_zone_identifier = module.vpc.private_subnets

#   target_group_arns = [aws_lb_target_group.app.arn]

#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.flask_app.id
#       }
#       override {
#         instance_type = "t2.micro"
#       }
#     }
#   }
# }

# resource "aws_autoscaling_policy" "app" {
#   name                   = "app"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.app.name

#   estimated_instance_warmup = 300

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }

#     target_value = 25.0
#   }
# }

# resource "aws_lb" "app" {
#   name               = "app"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]

#   subnets = var.public_subnets
# }

# resource "aws_lb_listener" "app" {
#   load_balancer_arn = aws_lb.app.arn
#   port              = "80"
#   protocol          = var.network_protocols[1]

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }
# }
