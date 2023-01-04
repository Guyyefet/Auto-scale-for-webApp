terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}

provider "aws" {
  # profile = "devops_user"
  region  = "us-east-1"
}

resource "aws_instance" "example1" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}