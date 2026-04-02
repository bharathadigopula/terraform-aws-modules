#==============================================================================
# GATEWAY VPC ENDPOINTS
#==============================================================================

resource "aws_vpc_endpoint" "gateway" {
  for_each = var.gateway_endpoints

  vpc_id            = var.vpc_id
  service_name      = each.value.service_name
  vpc_endpoint_type = "Gateway"
  policy            = each.value.policy

  tags = merge(var.tags, {
    Name = each.key
  })
}

#==============================================================================
# GATEWAY ENDPOINT ROUTE TABLE ASSOCIATIONS
#==============================================================================

locals {
  gateway_route_table_associations = merge([
    for ep_key, ep in var.gateway_endpoints : {
      for rt_id in ep.route_table_ids :
      "${ep_key}-${rt_id}" => {
        endpoint_key   = ep_key
        route_table_id = rt_id
      }
    }
  ]...)
}

resource "aws_vpc_endpoint_route_table_association" "this" {
  for_each = local.gateway_route_table_associations

  vpc_endpoint_id = aws_vpc_endpoint.gateway[each.value.endpoint_key].id
  route_table_id  = each.value.route_table_id
}

#==============================================================================
# INTERFACE VPC ENDPOINTS
#==============================================================================

resource "aws_vpc_endpoint" "interface" {
  for_each = var.interface_endpoints

  vpc_id              = var.vpc_id
  service_name        = each.value.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = each.value.subnet_ids
  security_group_ids  = each.value.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled
  policy              = each.value.policy

  tags = merge(var.tags, {
    Name = each.key
  })
}
