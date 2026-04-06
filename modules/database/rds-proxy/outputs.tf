#==============================================================================
# RDS Proxy Outputs
#==============================================================================
output "proxy_id" {
  description = "The ID of the RDS Proxy"
  value       = aws_db_proxy.this.id
}

output "proxy_arn" {
  description = "The ARN of the RDS Proxy"
  value       = aws_db_proxy.this.arn
}

output "proxy_endpoint" {
  description = "The endpoint that you can use to connect to the proxy"
  value       = aws_db_proxy.this.endpoint
}

output "target_group_arn" {
  description = "The ARN of the default target group"
  value       = aws_db_proxy_default_target_group.this.arn
}

output "target_group_name" {
  description = "The name of the default target group"
  value       = aws_db_proxy_default_target_group.this.name
}
