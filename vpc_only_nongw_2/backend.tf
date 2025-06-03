terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "eetse-vpc2.tfstate" #The name of the file in the bucket
    region = "ap-southeast-1"  
  }
}