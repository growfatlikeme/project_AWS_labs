################################################################################
# Outputs of the EBS Module
################################################################################

output "volume_id" {
  value = aws_ebs_volume.ebs_volume.id
  description = "The ID of the EBS volume"
}