terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "ec2-bastion_vpc2.tfstate" # Different key from the VPC state file
    region = "ap-southeast-1"  
  }
}