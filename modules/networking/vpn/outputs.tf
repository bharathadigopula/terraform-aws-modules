#==============================================================================
# CUSTOMER GATEWAY
#==============================================================================

output "customer_gateway_id" {
  value       = aws_customer_gateway.this.id
  description = "ID of the customer gateway"
}

#==============================================================================
# VPN GATEWAY
#==============================================================================

output "vpn_gateway_id" {
  value       = try(aws_vpn_gateway.this[0].id, var.vpn_gateway_id)
  description = "ID of the VPN gateway"
}

#==============================================================================
# VPN CONNECTION
#==============================================================================

output "vpn_connection_id" {
  value       = aws_vpn_connection.this.id
  description = "ID of the VPN connection"
}

output "vpn_connection_tunnel1_address" {
  value       = aws_vpn_connection.this.tunnel1_address
  description = "Public IP address of the first VPN tunnel"
}

output "vpn_connection_tunnel2_address" {
  value       = aws_vpn_connection.this.tunnel2_address
  description = "Public IP address of the second VPN tunnel"
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  value       = aws_vpn_connection.this.tunnel1_cgw_inside_address
  description = "Customer gateway inside address for tunnel 1"
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  value       = aws_vpn_connection.this.tunnel2_cgw_inside_address
  description = "Customer gateway inside address for tunnel 2"
}
