#==============================================================================
# TRANSIT GATEWAY
#==============================================================================

resource "aws_ec2_transit_gateway" "this" {
  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks

  tags = merge(var.tags, {
    Name = var.name
  })
}

#==============================================================================
# VPC ATTACHMENTS
#==============================================================================

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each = var.vpc_attachments

  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  dns_support                                     = each.value.dns_support
  appliance_mode_support                          = each.value.appliance_mode_support
  transit_gateway_default_route_table_association = each.value.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = each.value.transit_gateway_default_route_table_propagation

  tags = merge(var.tags, {
    Name = "${var.name}-${each.key}"
  })
}

#==============================================================================
# ROUTE TABLE
#==============================================================================

resource "aws_ec2_transit_gateway_route_table" "this" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = merge(var.tags, {
    Name = "${var.name}-rtb"
  })
}

#==============================================================================
# ROUTES
#==============================================================================

resource "aws_ec2_transit_gateway_route" "this" {
  count = length(var.route_table_routes)

  destination_cidr_block         = var.route_table_routes[count.index].destination_cidr_block
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.this.id
  transit_gateway_attachment_id  = var.route_table_routes[count.index].blackhole ? null : var.route_table_routes[count.index].transit_gateway_attachment_id
  blackhole                      = var.route_table_routes[count.index].blackhole
}

#==============================================================================
# RAM RESOURCE SHARE
#==============================================================================

resource "aws_ram_resource_share" "this" {
  count = var.ram_share_enabled ? 1 : 0

  name                      = "${var.name}-ram-share"
  allow_external_principals = true

  tags = merge(var.tags, {
    Name = "${var.name}-ram-share"
  })
}

resource "aws_ram_resource_association" "this" {
  count = var.ram_share_enabled ? 1 : 0

  resource_arn       = aws_ec2_transit_gateway.this.arn
  resource_share_arn = aws_ram_resource_share.this[0].arn
}

resource "aws_ram_principal_association" "this" {
  count = var.ram_share_enabled ? length(var.ram_principals) : 0

  principal          = var.ram_principals[count.index]
  resource_share_arn = aws_ram_resource_share.this[0].arn
}
