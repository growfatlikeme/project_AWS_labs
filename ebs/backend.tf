terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "eetse-ebs.tfstate" 
    region = "ap-southeast-1"  
  }
}