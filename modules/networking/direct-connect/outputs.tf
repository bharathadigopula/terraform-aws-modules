#==============================================================================
# CONNECTION OUTPUTS
#==============================================================================

output "connection_id" {
  description = "ID of the DX connection"
  value       = var.create_connection ? aws_dx_connection.this[0].id : var.dx_connection_id
}

output "connection_arn" {
  description = "ARN of the DX connection"
  value       = var.create_connection ? aws_dx_connection.this[0].arn : ""
}

#==============================================================================
# DX GATEWAY OUTPUTS
#==============================================================================

output "dx_gateway_id" {
  description = "ID of the Direct Connect gateway"
  value       = aws_dx_gateway.this.id
}

#==============================================================================
# VIRTUAL INTERFACE OUTPUTS
#==============================================================================

output "private_virtual_interface_id" {
  description = "ID of the private virtual interface"
  value       = var.create_private_virtual_interface ? aws_dx_private_virtual_interface.this[0].id : ""
}

output "transit_virtual_interface_id" {
  description = "ID of the transit virtual interface"
  value       = var.create_transit_virtual_interface ? aws_dx_transit_virtual_interface.this[0].id : ""
}

#==============================================================================
# GATEWAY ASSOCIATION OUTPUTS
#==============================================================================

output "gateway_association_id" {
  description = "ID of the DX gateway association"
  value       = var.associated_gateway_id != "" ? aws_dx_gateway_association.this[0].id : ""
}
