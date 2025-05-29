# The default provider configuration
provider "aws" {
  region = var.aws_region        # Dynamically fetch the region from variable

default_tags {
  tags = {
    Environment = "${var.environment}" # Dynamically fetch the environment from variable
    Name        = "${var.name}" # Dynamically fetch the name from variable
    Owner       = "NTU-SCTP-COHORT10"
    Project     = "project_AWS_labs"
  }
}
}