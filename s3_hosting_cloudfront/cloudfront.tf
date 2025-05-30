# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "oac" {
  provider                      = aws.us_east_1
  name                          = "${local.name_prefix}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior              = "always"
  signing_protocol              = "sigv4"
}

# CloudFront Distribution with managed WAF
resource "aws_cloudfront_distribution" "distribution" {
  provider        = aws.us_east_1
  enabled         = true
  is_ipv6_enabled = true
  comment         = "Distribution for ${local.name_prefix}.sctp-sandbox.com"
  aliases         = ["${local.name_prefix}.sctp-sandbox.com"]
  
  origin {
    domain_name              = aws_s3_bucket.s3bucket.bucket_regional_domain_name
    origin_id                = "S3-${local.name_prefix}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }
  
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${local.name_prefix}"
    viewer_protocol_policy = "redirect-to-https"

    # 658327ea-f89d-4fab-a63d-7e88639e58f6 is AWS's managed CachingOptimized policy ID
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
 
    
  
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  
  # Use AWS managed WAF ACL
  web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn
}