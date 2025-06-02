resource "aws_sns_topic" "alert_topic" {
 name = "${local.name_prefix}-alert-sns-topic"
}

resource "aws_sns_topic" "cart_topic" {
 count = var.cart_count
 name  = "${local.name_prefix}-cart-${count.index}-sns-topic"
}