module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  # database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  # manage_default_vpc = true


  tags = {
    name = "dev-vpc"
    Environment = "dev"
  }
}

data "aws_vpc" "dev-vpc" {
	filter {
		name  = "tag:Name"
		values = ["dev-vpc"]
	}
}

output "vpc" {
	value = data.aws_vpc.dev-vpc.id
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id =  data.aws_vpc.dev-vpc.id
}

resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id =  data.aws_vpc.dev-vpc.id
}

# resource "aws_security_group" "db_sg" {
#   name   = "db-sg"
#   vpc_id =  data.aws_vpc.dev-vpc.id
# }

resource "aws_security_group_rule" "ingress_ec2_traffic" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "ingress_ec2_health_check" {
  type                     = "ingress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

# # # resource "aws_security_group_rule" "full_egress_ec2" {
# # #   type              = "egress"
# # #   from_port         = 0
# # #   to_port           = 0
# # #   protocol          = "-1"
# # #   security_group_id = aws_security_group.ec2_sg.id
# # #   cidr_blocks       = ["0.0.0.0/0"]
# # # }

resource "aws_security_group_rule" "egress_alb_sg_traffic" {
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "egress_alb_sg_health_check" {
  type                     = "egress"
  from_port                = 8081
  to_port                  = 8081
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ingress_alb_sg_http_traffic" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_alb_sg_https_traffic" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "ingress_db_sg_traffic" {
#   type              = "ingress"
#   from_port         = 5432
#   to_port           = 5432
#   protocol          = "tcp"
#   security_group_id = aws_security_group.db_sg.id
  # source_security_group_id = aws_security_group.ec2_sg.id
  # cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "egress_db_sg_traffic" {
#   type              = "egress"
#   from_port         = 5432
#   to_port           = 5432
#   protocol          = "tcp"
#   security_group_id = aws_security_group.db_sg.id
  # source_security_group_id = aws_security_group.ec2_sg.id
  # cidr_blocks       = ["0.0.0.0/0"]
# }