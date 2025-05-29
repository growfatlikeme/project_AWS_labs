terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "eetse-terraform.tfstate" #The name of the file in the bucket
    region = "ap-southeast-1"  
  }
}