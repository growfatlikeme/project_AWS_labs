#If terraform apply is run with the staging.tfvars file, the values in the variables.tf file will be overridden by the values in the staging.tfvars file.
#This file defines globals variables to be used regardless of environment


################################################################################
# Naming
################################################################################


variable "name" {
  type = string
  description = "ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

################################################################################
# VPC
################################################################################

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "aws_region" {
  type    = string
  description = "AWS region to deploy resources"
}

variable "myvpc_cidr" {
  type = string
  description = "VPC CIDR range"
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
}

################################################################################
# Subnets
################################################################################

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
}

variable "database_subnet_cidrs" {
 type        = list(string)
 description = "Database Subnet CIDR values"
}

################################################################################
# NAT Gateway
################################################################################

variable "create_natgw" {
  description = "Whether to create NAT Gateway"
  type        = bool
}