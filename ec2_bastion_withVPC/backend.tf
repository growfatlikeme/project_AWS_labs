terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "ec2-bastion.tfstate" # Different key from the VPC state file
    region = "ap-southeast-1"  
  }
}