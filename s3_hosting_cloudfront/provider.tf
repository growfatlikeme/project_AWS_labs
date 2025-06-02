# The default provider configuration
provider "aws" {
  region = var.aws_region       # Dynamically fetch the region from variable
  alias = "ap_southeast_1" # Alias for the provider to use in the module

default_tags {
  tags = {
    Environment = "${var.environment}" # Dynamically fetch the environment from variable
    Name        = "${var.name}" # Dynamically fetch the name from variable
    Owner       = "NTU-SCTP-COHORT10"
    Project     = "project_AWS_labs"
  }
}
}

#Additional provider configuration for cloudfront 
provider "aws" {
  region = "us-east-1"
  alias = "us_east_1" # Alias for the provider to use in the module
  
  default_tags {
  tags = {
    Environment = "${var.environment}" # Dynamically fetch the environment from variable
    Name        = "${var.name}" # Dynamically fetch the name from variable
    Owner       = "NTU-SCTP-COHORT10"
    Project     = "project_AWS_labs"
  }
}
}