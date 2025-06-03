# Create EC2 instance in the public subnet
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon2023.id
  instance_type          = var.instance_type
  
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  
  key_name               = aws_key_pair.bastion_key.key_name

  user_data = base64encode(templatefile("init-script.tpl", {
    name_prefix = local.name_prefix
  }))

  user_data_replace_on_change = true # this forces instance to be recreated upon update of user data contents

  tags = {
    Name = "${local.name_prefix}-bastion_vpc2"
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

