# Reference the remote state from vpc_only_nongw
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "eetse-terraform-state"
    key    = "eetse-terraform.tfstate"
    region = "ap-southeast-1"
  }
}
