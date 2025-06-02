variable "name" {
  type = string
  description = "Ownership of resources"
}

variable "environment" {
  type = string
  description = "Environment type (dev, staging, prod)"
}

variable "cart_count" {
 type    = number
 default = 0
}
