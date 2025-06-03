resource "aws_db_subnet_group" "database" {
  name        = "${local.name_prefix}-rds-subnet-group"
  description = "Database subnet group for ${local.name_prefix}"
  subnet_ids  = local.database_subnet_ids
  
  tags = {
    Name = "${local.name_prefix}-rds-subnet-group"
  }
}