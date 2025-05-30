provider "aws" {
  region = var.aws_region
  alias  = "ap_southeast_1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}