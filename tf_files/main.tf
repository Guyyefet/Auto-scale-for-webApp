terraform {
  backend "s3" {
      # Replace this with your bucket name!
    bucket         = "terraform-store-state-in-s3-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    profile = "devops_user"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
    shared_credentials_file = "$HOME/.aws/credentials"
  }
}

provider "aws" {
  profile = "devops_user"
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}

