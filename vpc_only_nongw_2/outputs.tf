output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = var.myvpc_cidr
}

output "subnet_names_public" {
  description = "Map of public subnet IDs to names"
  value       = { for subnet in aws_subnet.public_subnets : subnet.id => subnet.tags.Name }
}

output "subnet_names_private" {
  description = "Map of private subnet IDs to names"
  value       = { for subnet in aws_subnet.private_subnets : subnet.id => subnet.tags.Name }
}

output "subnet_names_database" {
  description = "Map of database subnet IDs to names"
  value       = { for subnet in aws_subnet.database_subnets : subnet.id => subnet.tags.Name }
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "database_subnet_ids" {
  description = "List of database subnet IDs"
  value       = [for subnet in aws_subnet.database_subnets : subnet.id]
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_rt.id
}

#output for RDS resources where required
output "database_subnet_ids_with_tags" {
  description = "Map of database subnet IDs with their tags"
  value = {
    for k, subnet in aws_subnet.database_subnets : 
      subnet.id => subnet.tags
  }
}

#output for security groups where required
output "subnet_data" {
  description = "Map of subnet IDs to their data including CIDR blocks and tags"
  value = merge(
    { for k, v in aws_subnet.public_subnets : v.id => {
        cidr_block = v.cidr_block
        tags       = v.tags
      }
    },
    { for k, v in aws_subnet.private_subnets : v.id => {
        cidr_block = v.cidr_block
        tags       = v.tags
      }
    },
    { for k, v in aws_subnet.database_subnets : v.id => {
        cidr_block = v.cidr_block
        tags       = v.tags
      }
    }
  )
}