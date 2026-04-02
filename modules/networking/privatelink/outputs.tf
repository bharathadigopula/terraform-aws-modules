#==============================================================================
# GATEWAY ENDPOINT OUTPUTS
#==============================================================================

output "gateway_endpoint_ids" {
  value = {
    for k, v in aws_vpc_endpoint.gateway : k => v.id
  }
  description = "Map of gateway endpoint keys to their IDs"
}

#==============================================================================
# INTERFACE ENDPOINT OUTPUTS
#==============================================================================

output "interface_endpoint_ids" {
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.id
  }
  description = "Map of interface endpoint keys to their IDs"
}

output "interface_endpoint_dns_entries" {
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.dns_entry
  }
  description = "Map of interface endpoint keys to their DNS entries"
}

output "interface_endpoint_network_interface_ids" {
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.network_interface_ids
  }
  description = "Map of interface endpoint keys to their network interface IDs"
}
