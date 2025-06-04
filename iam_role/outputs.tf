output "instance_profile_name" {
  description = "The name of the instance profile"
  value       = aws_iam_instance_profile.profile_sample.name
}

output "policy_document" {
  description = "The JSON document of the IAM policy"
  value       = aws_iam_policy.policy_sample.policy
}
