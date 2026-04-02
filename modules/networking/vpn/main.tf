#==============================================================================
# LOCAL VALUES
#==============================================================================

locals {
  vpn_gateway_id = var.create_vpn_gateway ? aws_vpn_gateway.this[0].id : var.vpn_gateway_id
  use_tgw        = var.transit_gateway_id != null
}

#==============================================================================
# CUSTOMER GATEWAY
#==============================================================================

resource "aws_customer_gateway" "this" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip_address
  type       = var.customer_gateway_type

  tags = merge(var.tags, {
    Name = "${var.name}-cgw"
  })
}

#==============================================================================
# VPN GATEWAY
#==============================================================================

resource "aws_vpn_gateway" "this" {
  count = var.create_vpn_gateway ? 1 : 0

  amazon_side_asn = var.vpn_gateway_amazon_side_asn

  tags = merge(var.tags, {
    Name = "${var.name}-vgw"
  })
}

#==============================================================================
# VPN GATEWAY ATTACHMENT
#==============================================================================

resource "aws_vpn_gateway_attachment" "this" {
  count = var.create_vpn_gateway && var.vpc_id != null ? 1 : 0

  vpc_id         = var.vpc_id
  vpn_gateway_id = aws_vpn_gateway.this[0].id
}

#==============================================================================
# VPN CONNECTION
#==============================================================================

resource "aws_vpn_connection" "this" {
  customer_gateway_id = aws_customer_gateway.this.id
  type                = var.customer_gateway_type
  static_routes_only  = var.static_routes_only

  vpn_gateway_id     = local.use_tgw ? null : local.vpn_gateway_id
  transit_gateway_id = local.use_tgw ? var.transit_gateway_id : null

  local_ipv4_network_cidr  = var.local_ipv4_network_cidr
  remote_ipv4_network_cidr = var.remote_ipv4_network_cidr

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(var.tags, {
    Name = "${var.name}-vpn"
  })
}

#==============================================================================
# VPN STATIC ROUTES
#==============================================================================

resource "aws_vpn_connection_route" "this" {
  for_each = toset(var.static_routes_destinations)

  vpn_connection_id      = aws_vpn_connection.this.id
  destination_cidr_block = each.value
}

#==============================================================================
# VPN GATEWAY ROUTE PROPAGATION
#==============================================================================

resource "aws_vpn_gateway_route_propagation" "this" {
  for_each = var.enable_vpn_gateway_route_propagation && !local.use_tgw ? toset(var.route_table_ids) : toset([])

  vpn_gateway_id = local.vpn_gateway_id
  route_table_id = each.value
}
