provider "aws" {
  profile = "devops_user"
  region  = "us-east-1"
  access_key= AKIASUYKOXW37ZW7CSPP
  secret_key= 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
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}
