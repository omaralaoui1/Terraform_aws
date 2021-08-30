provider "aws" {
  version = "3.56.0"
  region = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key =  var.AWS_SECRET_KEY
}