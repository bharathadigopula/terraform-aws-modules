#==============================================================================
# VPC PEERING CONNECTION OUTPUTS
#==============================================================================

output "peering_connection_id" {
  description = "The ID of the VPC peering connection"
  value       = aws_vpc_peering_connection.this.id
}

output "peering_connection_status" {
  description = "The status of the VPC peering connection"
  value       = aws_vpc_peering_connection.this.accept_status
}

output "requester_vpc_id" {
  description = "The ID of the requester VPC"
  value       = aws_vpc_peering_connection.this.vpc_id
}

output "accepter_vpc_id" {
  description = "The ID of the accepter VPC"
  value       = aws_vpc_peering_connection.this.peer_vpc_id
}
