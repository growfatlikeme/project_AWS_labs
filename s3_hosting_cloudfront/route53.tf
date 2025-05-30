# Route53 data source for the hosted zone
data "aws_route53_zone" "main" {
  name = "sctp-sandbox.com"
  private_zone = false
}

# Route53 A record for the domain
resource "aws_route53_record" "domain" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${local.name_prefix}.sctp-sandbox.com"
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}