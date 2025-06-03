# Reference the remote state from vpc_only_nongw
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "eetse-terraform-state"
    key    = "eetse-vpc2.tfstate"
    region = "ap-southeast-1"
  }
}

#query to read latest Amazon Linux 2023 AMI
data "aws_ami" "amazon2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }
  owners = ["amazon"]
}