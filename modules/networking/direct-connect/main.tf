#==============================================================================
# LOCAL VALUES
#==============================================================================

locals {
  connection_id = var.create_connection ? aws_dx_connection.this[0].id : var.dx_connection_id
}

#==============================================================================
# DX CONNECTION
#==============================================================================

resource "aws_dx_connection" "this" {
  count = var.create_connection ? 1 : 0

  name            = var.name
  bandwidth       = var.connection_bandwidth
  location        = var.connection_location
  provider_name   = var.connection_provider_name
  tags            = merge(var.tags, { Name = var.name })
}

#==============================================================================
# DX GATEWAY
#==============================================================================

resource "aws_dx_gateway" "this" {
  name            = coalesce(var.dx_gateway_name, "${var.name}-dxgw")
  amazon_side_asn = var.dx_gateway_asn
}

#==============================================================================
# DX GATEWAY ASSOCIATION
#==============================================================================

resource "aws_dx_gateway_association" "this" {
  count = var.associated_gateway_id != "" ? 1 : 0

  dx_gateway_id         = aws_dx_gateway.this.id
  associated_gateway_id = var.associated_gateway_id

  dynamic "allowed_prefixes" {
    for_each = var.allowed_prefixes
    content {
      cidr = allowed_prefixes.value
    }
  }
}

#==============================================================================
# PRIVATE VIRTUAL INTERFACE
#==============================================================================

resource "aws_dx_private_virtual_interface" "this" {
  count = var.create_private_virtual_interface ? 1 : 0

  connection_id    = local.connection_id
  name             = coalesce(var.private_vif_name, "${var.name}-private-vif")
  vlan             = var.private_vif_vlan
  bgp_asn          = var.private_vif_bgp_asn
  address_family   = var.private_vif_address_family
  amazon_address   = var.private_vif_amazon_address != "" ? var.private_vif_amazon_address : null
  customer_address = var.private_vif_customer_address != "" ? var.private_vif_customer_address : null
  dx_gateway_id    = aws_dx_gateway.this.id
  mtu              = var.private_vif_mtu
  tags             = merge(var.tags, { Name = coalesce(var.private_vif_name, "${var.name}-private-vif") })
}

#==============================================================================
# TRANSIT VIRTUAL INTERFACE
#==============================================================================

resource "aws_dx_transit_virtual_interface" "this" {
  count = var.create_transit_virtual_interface ? 1 : 0

  connection_id  = local.connection_id
  name           = coalesce(var.transit_vif_name, "${var.name}-transit-vif")
  vlan           = var.transit_vif_vlan
  bgp_asn        = var.transit_vif_bgp_asn
  address_family = var.transit_vif_address_family
  dx_gateway_id  = aws_dx_gateway.this.id
  mtu            = var.transit_vif_mtu
  tags           = merge(var.tags, { Name = coalesce(var.transit_vif_name, "${var.name}-transit-vif") })
}
