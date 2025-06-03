resource "aws_dynamodb_table" "dynamodb" {
  name         = "${local.name_prefix}-dynamodb-books"
  billing_mode = "PAY_PER_REQUEST"

  # Define primary keys (Partition + Sort Key)
  hash_key     = "ISBN"
  range_key    = "Genre"

  attribute {
    name = "ISBN"
    type = "S"
  }

  attribute {
    name = "Genre"
    type = "S"
  }

  provisioner "local-exec" {
    command = "./sampledata.sh \"${local.name_prefix}-dynamodb-books\" \"${var.aws_region}\""
  }

  provisioner "local-exec" {
    command = "aws dynamodb scan --table-name ${local.name_prefix}-dynamodb-books"
  }

  provisioner "local-exec" {
    command = "aws dynamodb query --table-name ${local.name_prefix}-dynamodb-books --key-condition-expression \"ISBN = :isbn\" --expression-attribute-values '{\":isbn\":{\"S\":\"978-01346854325\"}}'"
  }

  tags = {
    Name = "${local.name_prefix}-dynamodb-books"
  }
}
