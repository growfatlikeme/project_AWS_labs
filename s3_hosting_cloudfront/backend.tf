terraform {
  backend "s3" {
    bucket = "eetse-terraform-state"
    key    = "s3_cf_static.tfstate" #The name of the file in the bucket
    region = "ap-southeast-1"  
  }
}