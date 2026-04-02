#==============================================================================
# TRANSIT GATEWAY OUTPUTS
#==============================================================================

output "transit_gateway_id" {
  value       = aws_ec2_transit_gateway.this.id
  description = "ID of the Transit Gateway"
}

output "transit_gateway_arn" {
  value       = aws_ec2_transit_gateway.this.arn
  description = "ARN of the Transit Gateway"
}

output "transit_gateway_route_table_id" {
  value       = aws_ec2_transit_gateway_route_table.this.id
  description = "ID of the Transit Gateway route table"
}

output "vpc_attachment_ids" {
  value       = { for k, v in aws_ec2_transit_gateway_vpc_attachment.this : k => v.id }
  description = "Map of VPC attachment keys to their IDs"
}

output "ram_resource_share_id" {
  value       = var.ram_share_enabled ? aws_ram_resource_share.this[0].id : null
  description = "ID of the RAM resource share"
}
