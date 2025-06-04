output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_instance_id" {
  description = "Instance ID of the bastion host"
  value       = aws_instance.bastion.id
}

output "availability_zone" {
  description = "Availability zone of the ec2_public instances"
  value = aws_instance.bastion.availability_zone
  }
  