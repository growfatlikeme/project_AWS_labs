
locals {
  name_prefix = "${var.name}-${var.environment}"
}

# Use a local variable to determine if we need to create a new key
locals {
  key_name = "${local.name_prefix}-bastion-key"
}
