#==============================================================================
# VPC PEERING CONNECTION
#==============================================================================

resource "aws_vpc_peering_connection" "this" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_owner_id = var.peer_owner_id
  peer_region   = var.peer_region
  auto_accept   = var.auto_accept

  tags = merge(var.tags, {
    Name = var.name
  })
}

#==============================================================================
# VPC PEERING CONNECTION ACCEPTER
#==============================================================================

resource "aws_vpc_peering_connection_accepter" "this" {
  count = var.auto_accept ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = merge(var.tags, {
    Name = var.name
  })
}

#==============================================================================
# VPC PEERING CONNECTION OPTIONS - REQUESTER
#==============================================================================

resource "aws_vpc_peering_connection_options" "requester" {
  count = var.auto_accept ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  requester {
    allow_remote_vpc_dns_resolution = var.allow_requester_dns_resolution
  }

  depends_on = [aws_vpc_peering_connection_accepter.this]
}

#==============================================================================
# VPC PEERING CONNECTION OPTIONS - ACCEPTER
#==============================================================================

resource "aws_vpc_peering_connection_options" "accepter" {
  count = var.auto_accept ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_accepter_dns_resolution
  }

  depends_on = [aws_vpc_peering_connection_accepter.this]
}

#==============================================================================
# ROUTES - REQUESTER TO ACCEPTER
#==============================================================================

resource "aws_route" "requester" {
  count = var.accepter_vpc_cidr != null ? length(var.requester_route_table_ids) : 0

  route_table_id            = var.requester_route_table_ids[count.index]
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

#==============================================================================
# ROUTES - ACCEPTER TO REQUESTER
#==============================================================================

resource "aws_route" "accepter" {
  count = var.requester_vpc_cidr != null ? length(var.accepter_route_table_ids) : 0

  route_table_id            = var.accepter_route_table_ids[count.index]
  destination_cidr_block    = var.requester_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
