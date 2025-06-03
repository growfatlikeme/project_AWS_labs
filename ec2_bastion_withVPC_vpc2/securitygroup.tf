# Create security group for bastion host
resource "aws_security_group" "bastion_sg" {
  name        = "${local.name_prefix}-bastion-sg_vpc2"
  description = "Security group for bastion host"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
   description = "Allow HTTP from anywhere"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]

  }


  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    prevent_destroy = false  # Ensures Terraform allows deletion
  }

  tags = {
    Name = "${local.name_prefix}-bastion-sg"
  }
}
