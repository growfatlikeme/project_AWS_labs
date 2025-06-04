# Define the policy document with DynamoDB permissions
data "aws_iam_policy_document" "policy_sample" {
  statement {
    effect = "Allow"
    actions = ["ec2:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:ListTables",
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:BatchGetItem"
    ]
    resources = ["*"]
  }
}
