resource "aws_db_instance" "rds_mysql" {
  identifier           = "${local.name_prefix}-mysql"
  engine              = "mysql"
  instance_class      = "db.t4g.micro"  # Free tier eligible
  allocated_storage   = 20             # Minimum storage for free tier
  storage_type        = "gp2"
  publicly_accessible = false          # No public access
  db_subnet_group_name = aws_db_subnet_group.database.name  # Use the subnet group from the network module
  vpc_security_group_ids = [aws_security_group.rds_sg.id]  # Use the security group from the security module

  username             = "admin"
  manage_master_user_password = true  # Managed in AWS Secrets Manager

  skip_final_snapshot  = true  # Prevents snapshot on deletion
  deletion_protection  = false # Disable deletion protection for easy cleanup
}