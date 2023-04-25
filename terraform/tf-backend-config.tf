# terraform {
#   backend "s3" {
#     bucket         = "terraform-store-state-in-s3-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     # profile = "devops_user"

#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#     # shared_credentials_file = "$HOME/.aws/credentials"
#   }
# }

# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }