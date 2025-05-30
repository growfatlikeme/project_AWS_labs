# The default provider configuration
provider "aws" {
  region = "ap-southeast-1"        # Dynamically fetch the region from variable
  alias = "ap-southeast-1" # Alias for the provider to use in the module

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
  alias = "us-east-1" # Alias for the provider to use in the module
  
  default_tags {
  tags = {
    Environment = "${var.environment}" # Dynamically fetch the environment from variable
    Name        = "${var.name}" # Dynamically fetch the name from variable
    Owner       = "NTU-SCTP-COHORT10"
    Project     = "project_AWS_labs"
  }
}
}