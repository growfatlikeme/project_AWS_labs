#variables specific to network module depending on tfvars invoked, may override

variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}