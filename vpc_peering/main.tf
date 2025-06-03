resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = data.terraform_remote_state.vpc1.outputs.vpc_id
  peer_vpc_id   = data.terraform_remote_state.vpc2.outputs.vpc_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }


  tags = {
    Name = "${local.name_prefix}-vpc-peering"
  }
}

# Route from VPC1 public route table to VPC2
resource "aws_route" "route_vpc1_public_to_vpc2" {
  route_table_id            = data.terraform_remote_state.vpc1.outputs.public_route_table_id
  destination_cidr_block    = data.terraform_remote_state.vpc2.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route from VPC1 private route table to VPC2
resource "aws_route" "route_vpc1_private_to_vpc2" {
  route_table_id            = data.terraform_remote_state.vpc1.outputs.private_route_table_id
  destination_cidr_block    = data.terraform_remote_state.vpc2.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route from VPC2 public route table to VPC1
resource "aws_route" "route_vpc2_public_to_vpc1" {
  route_table_id            = data.terraform_remote_state.vpc2.outputs.public_route_table_id
  destination_cidr_block    = data.terraform_remote_state.vpc1.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route from VPC2 private route table to VPC1
resource "aws_route" "route_vpc2_private_to_vpc1" {
  route_table_id            = data.terraform_remote_state.vpc2.outputs.private_route_table_id
  destination_cidr_block    = data.terraform_remote_state.vpc1.outputs.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}