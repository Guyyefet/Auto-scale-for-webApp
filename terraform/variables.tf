variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "instance type"
}

# variable "instance_tags" {
#   type = object({
#     Name = string

#   })
# }



# variable "vpc_id" {
#   type = string
#   default = data.aws_vpc.dev-vpc.id
#   description = "vpc_id"
# }

variable "regions" {
  type = list(string)
  description = "list of aws regions"
}

variable "availability_zones" {
  type = list(string)
  description = "availability zones"
}

variable "private_subnets" {
  type = list(string)
  description = "private subnets cidr blocks"
}

variable "public_subnets" {
  type = list(string)
  description = "public subnets cidr blocks"
}

variable "ec2_traffic_port" {
   type = number
   default = 8080
}

variable "health_check_port" {
   type = number
   default = 8081
}

variable "ingress_alb_port" {
  type = number
  default = 80
}

variable "ec2_security_group_id" {
  type = string
}

variable "network_protocols" {
  type = list(string)
}

variable "ingress" {
  type = string
  default = "ingress"
}

variable "egress" {
  type = string
  default = "egress"
}