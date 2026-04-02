#==============================================================================
# VPC OUTPUTS
#==============================================================================

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block of the VPC"
  value       = aws_vpc.this.ipv6_cidr_block
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with the VPC"
  value       = aws_vpc.this.main_route_table_id
}

output "vpc_default_security_group_id" {
  description = "The ID of the default security group"
  value       = aws_vpc.this.default_security_group_id
}

output "vpc_default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = aws_vpc.this.default_network_acl_id
}

output "vpc_default_route_table_id" {
  description = "The ID of the default route table"
  value       = aws_vpc.this.default_route_table_id
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = aws_vpc.this.owner_id
}

#==============================================================================
# INTERNET GATEWAY OUTPUTS
#==============================================================================

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].arn, null)
}

#==============================================================================
# DHCP OPTIONS OUTPUTS
#==============================================================================

output "dhcp_options_id" {
  description = "The ID of the DHCP options set"
  value       = try(aws_vpc_dhcp_options.this[0].id, null)
}

#==============================================================================
# FLOW LOG OUTPUTS
#==============================================================================

output "flow_log_id" {
  description = "The ID of the VPC flow log"
  value       = try(aws_flow_log.this[0].id, null)
}

output "flow_log_cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch log group for flow logs"
  value       = try(aws_cloudwatch_log_group.flow_log[0].arn, null)
}
