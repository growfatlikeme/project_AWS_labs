resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = try(data.terraform_remote_state.ec2.outputs.availability_zone, null)  # Match EC2's AZ
  size              = 1  # 1 GB volume
  type              = "gp3"
  iops              = 3000
  throughput        = 125

  tags = {
    Name = "${local.name_prefix}-ebs-volume"
  }

}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = try(data.terraform_remote_state.ec2.outputs.bastion_instance_id, null)  

  lifecycle {
    prevent_destroy = false  # Allow Terraform to destroy this attachment
  }
}