#!/bin/bash


# Define the S3 Bucket details
BUCKET_NAME="eetse-terraform-state"
AWS_REGION="ap-southeast-1"

# Check if the S3 bucket already exists
BUCKET_EXISTS=$(aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null && echo "yes" || echo "no")

if [ "$BUCKET_EXISTS" == "yes" ]; then
    echo "✅ S3 bucket '$BUCKET_NAME' already exists. Skipping setup."
    exit 0  # Exit successfully without running setup
else
    echo "🚀 S3 bucket '$BUCKET_NAME' does not exist. Setting up Terraform backend..."

    # Create the S3 bucket
    aws s3api create-bucket --bucket $BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=ap-southeast-1

    # Enable versioning (Suspended)
    aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Suspended

    # Enable server-side encryption (AES256)
    aws s3api put-bucket-encryption --bucket $BUCKET_NAME --server-side-encryption-configuration '
    {
      "Rules": [
        {
          "ApplyServerSideEncryptionByDefault": {
            "SSEAlgorithm": "AES256"
          }
        }
      ]
    }'

    # Block public access
    aws s3api put-public-access-block --bucket $BUCKET_NAME --public-access-block-configuration '
    {
      "BlockPublicAcls": true,
      "BlockPublicPolicy": true,
      "IgnorePublicAcls": true,
      "RestrictPublicBuckets": true
    }'

    echo "✅ S3 bucket setup completed successfully!"
    exit 0
fi
