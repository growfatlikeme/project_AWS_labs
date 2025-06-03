
locals {

  name_prefix = "${var.name}-${var.environment}"

  # Fetching database subnet IDs from the remote state
  database_subnets = {
    for subnet_id, tags in data.terraform_remote_state.vpc.outputs.database_subnet_ids_with_tags :
      subnet_id => tags if contains(values(tags), "${local.name_prefix}-database-subnet-1") || 
                          contains(values(tags), "${local.name_prefix}-database-subnet-2") ||
                          contains(values(tags), "${local.name_prefix}-database-subnet-3")
  }
  
  database_subnet_ids = keys(local.database_subnets)


  # Extract private subnet CIDRs from remote state
  private_subnet_cidrs = [
    for subnet_id, subnet_data in data.terraform_remote_state.vpc.outputs.subnet_data : 
    subnet_data.cidr_block
    if contains(keys(subnet_data.tags), "Name") && 
       can(regex(".*private-subnet.*", subnet_data.tags["Name"]))
  ]
}

output "private_subnet_cidrs_output" {
  value = local.private_subnet_cidrs
  
}