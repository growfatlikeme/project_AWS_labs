#This module creates an IAM role, policy, and instance profile for EC2 instances.

#IAM role for ec2 instances
resource "aws_iam_role" "role_sample" {
  
 name = "${local.name_prefix}-role-sample"

 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Sid    = ""
       Principal = {
         Service = "ec2.amazonaws.com"
       }
     },
   ]
 })
}

/*
#IAM policy 
## Option 1: Attach data block policy document
resource "aws_iam_policy" "policy_sample" {
 name = "${local.name_prefix}-policy-sample"

 policy = data.aws_iam_policy_document.policy_sample.json

}

*/

## Option 2: Inline using jsonencode
resource "aws_iam_policy" "policy_sample" {
  name = "${local.name_prefix}-policy-sample"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Describe*"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ListAllMyBuckets"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:ListTables",
          "dynamodb:GetItem",
          "dynamodb:DescribeTable",
          "dynamodb:BatchGetItem"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBSecurityGroups",
          "rds:DescribeDBParameters",
          "rds:DescribeDBParameterGroups",
          "rds:ListTagsForResource"
        ]
        Resource = "*"
      }
    ]
  })
}




/*

## Option 3: Inline using heredoc
resource "aws_iam_policy" "policy_sample" {
 name = "${local.name_prefix}-policy-sample"


 policy = <<POLICY
   {
       "Statement": [
           {
               "Action": "ec2:Describe*",
               "Effect": "Allow",
               "Resource": "*"
           },
           {
               "Action": "s3:ListBucket",
               "Effect": "Allow",
               "Resource": "*"
           }
       ],
       "Version": "2012-10-17"
   }
   POLICY

}

*/
/*
# This resource ensures that only `exampleInlinePolicy` is assigned to this role. Any other inline policies will be removed.
resource "aws_iam_role_policies_exclusive" "example" {
  role_name    = aws_iam_role.example.name
  policy_names = [aws_iam_role_policy.example.name]
}
*/

resource "aws_iam_role_policy_attachment" "attach_sample" {
 role       = aws_iam_role.role_sample.name
 policy_arn = aws_iam_policy.policy_sample.arn
}

resource "aws_iam_instance_profile" "profile_sample" {
 name = "${local.name_prefix}-profile-sample"
 role = aws_iam_role.role_sample.name
}

