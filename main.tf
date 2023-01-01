# terraform {
#   backend "s3" {
#       # Replace this with your bucket name!
#     bucket         = "terraform-store-state-in-s3-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#     # shared_credentials_file = "$HOME/.aws/credentials"
#   }
# }

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

# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}