# Outputs for the database module

output "db_instance_id" {
  description = "The ID of the database instance"
  value       = aws_dynamodb_table.dynamodb.id
}