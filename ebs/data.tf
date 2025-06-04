# Reference the remote state from ec2_bastion_withVPC
data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "eetse-terraform-state"
    key    = "ec2-bastion.tfstate"
    region = "ap-southeast-1"
  }
}
