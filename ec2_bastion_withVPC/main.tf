# Create EC2 instance in the public subnet
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon2023.id
  instance_type          = var.instance_type
  
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  
  key_name               = aws_key_pair.bastion_key.key_name

  user_data = <<-EOF
            #!/bin/bash
            echo "export AWS_DEFAULT_REGION=${var.aws_region}" >> /etc/profile
            mkdir -p /home/ec2-user/.aws
            echo "[default]" > /home/ec2-user/.aws/config
            echo "region = ${var.aws_region}" >> /home/ec2-user/.aws/config
            chown -R ec2-user:ec2-user /home/ec2-user/.aws
            while [ ! -e /dev/xvdf ]; do
              echo "Waiting for EBS volume to be attached..."
              sleep 10
            done

            sudo mkfs -t ext4 /dev/xvdf
            sudo mkdir /mydata
            sudo mount /dev/xvdf /mydata/
            EOF

  user_data_replace_on_change = true # this forces instance to be recreated upon update of user data contents

  tags = {
    Name = "${local.name_prefix}-bastion"
  }

  lifecycle {
    create_before_destroy = true
  }
  
  depends_on = [aws_key_pair.bastion_key]

  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}


# This resource is used to create a default EC2 instance metadata options
resource "aws_ec2_instance_metadata_defaults" "enforce-imdsv2" {
  http_tokens = "optional"
}

