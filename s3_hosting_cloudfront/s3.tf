# This module creates an S3 bucket for hosting a static website.

resource "aws_s3_bucket" "s3bucket" {  
  bucket = "${local.name_prefix}.sctp-sandbox.com"
  provider = aws.ap_southeast_1

  tags = {
    Name = "${local.name_prefix}.sctp-sandbox.com"
  }

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.s3bucket.id
  provider = aws.ap_southeast_1

  index_document {
    suffix = "index.html"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.s3bucket.id
  provider = aws.ap_southeast_1
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.s3bucket.id
  provider = aws.ap_southeast_1

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.distribution.arn
          }
        }
      }
    ]
  })

  depends_on = [aws_cloudfront_distribution.distribution]
}

# Create a null resource to trigger the sync
resource "null_resource" "website_sync" {
  # Trigger sync when any of these change
  triggers = {
    bucket_name = aws_s3_bucket.s3bucket.id
    # Add a timestamp to force sync on every apply if needed
    timestamp = timestamp()
  }

  # Use local-exec to run aws s3 sync
  provisioner "local-exec" {
  # Sync website files to S3 bucket and then trigger CloudFront invalidation on all paths
  command = <<-EOT
    aws s3 sync website/ s3://${aws_s3_bucket.s3bucket.bucket}/ --delete --exclude "*.md" --exclude "*.MD" --exclude ".git*"
    
    aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.distribution.id} --paths "/*"
  EOT
}

  # Only run after the bucket and all its configurations are created
  depends_on = [
    aws_s3_bucket.s3bucket,
    aws_s3_bucket_website_configuration.static_site,
    aws_s3_bucket_public_access_block.allow_public_access
  ]
}

# Implement Cache-Control headers for S3 objects to optimize CloudFront caching
# Cache-Control headers for different file types
resource "aws_s3_object" "html" {
  for_each = fileset("website/", "**/*.html")
  
  bucket       = aws_s3_bucket.s3bucket.id
  key          = each.value
  source       = "website/${each.value}"
  content_type = "text/html"
  etag         = filemd5("website/${each.value}")
  
  # Short cache for HTML files (5 minutes)
  cache_control = "max-age=300"
}

resource "aws_s3_object" "css" {
  for_each = fileset("website/", "**/*.css")
  
  bucket       = aws_s3_bucket.s3bucket.id
  key          = each.value
  source       = "website/${each.value}"
  content_type = "text/css"
  etag         = filemd5("website/${each.value}")
  
  # Longer cache for CSS (1 week)
  cache_control = "max-age=604800"
}

resource "aws_s3_object" "js" {
  for_each = fileset("website/", "**/*.js")
  
  bucket       = aws_s3_bucket.s3bucket.id
  key          = each.value
  source       = "website/${each.value}"
  content_type = "application/javascript"
  etag         = filemd5("website/${each.value}")
  
  # Longer cache for JS (1 week)
  cache_control = "max-age=604800"
}

resource "aws_s3_object" "images" {
  for_each = fileset("website/", "**/*.{jpg,jpeg,png,gif,svg}")
  
  bucket       = aws_s3_bucket.s3bucket.id
  key          = each.value
  source       = "website/${each.value}"
  content_type = lookup({
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "png"  = "image/png",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml"
  }, split(".", each.value)[length(split(".", each.value)) - 1])
  etag         = filemd5("website/${each.value}")
  
  # Long cache for images (1 month)
  cache_control = "max-age=2592000"
}