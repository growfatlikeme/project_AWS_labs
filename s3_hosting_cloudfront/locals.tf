locals {
  name_prefix = "${var.name}-${var.environment}"
  
  domain_name = "${local.name_prefix}.sctp-sandbox.com"  # e.g., estee-dev.sctp-sandbox.com
  bucket_name = "${local.name_prefix}-s3.sctp-sandbox.com"
}