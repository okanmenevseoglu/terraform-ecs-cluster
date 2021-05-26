# AWS provider. Please provide your own AWS_ACCESS_KEY and AWS_SECRET_KEY to enable access
provider "aws" {
  region = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}
