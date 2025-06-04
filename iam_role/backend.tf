terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "eetse-iamrole.tfstate" #The name of the file in the bucket
    region = "ap-southeast-1"  
  }
}