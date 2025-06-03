# Reference the remote state from vpc_only_nongw
data "terraform_remote_state" "vpc1" {
  backend = "s3"
  config = {
    bucket = "eetse-terraform-state"
    key    = "eetse-vpc.tfstate"
    region = "ap-southeast-1"
  }
}

# Reference the remote state from vpc_only_nongw_2
data "terraform_remote_state" "vpc2" {
  backend = "s3"
  config = {
    bucket = "eetse-terraform-state"
    key    = "eetse-vpc2.tfstate" 
    region = "ap-southeast-1"  
  }
}
