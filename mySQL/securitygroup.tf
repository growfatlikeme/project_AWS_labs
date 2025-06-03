resource "aws_security_group" "rds_sg" {
  name        = "${local.name_prefix}-rds-sg"
  description = "Allow DB traffic from private subnet of VPC with CIDR range retrieved from remote state"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Example: Allow connections from internal application instances
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = local.private_subnet_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
