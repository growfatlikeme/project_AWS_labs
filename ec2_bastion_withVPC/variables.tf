variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "name" {
  type        = string
  description = "Ownership of resources"
}

variable "environment" {
  type        = string
  description = "Environment type (dev, staging, prod)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}
