#==============================================================================
# NETWORK LOAD BALANCER OUTPUTS
#==============================================================================

output "nlb_id" {
  description = "ID of the Network Load Balancer"
  value       = aws_lb.this.id
}

output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = aws_lb.this.arn
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = aws_lb.this.dns_name
}

output "nlb_zone_id" {
  description = "Canonical hosted zone ID of the Network Load Balancer"
  value       = aws_lb.this.zone_id
}

output "target_group_arns" {
  description = "ARNs of the target groups"
  value       = aws_lb_target_group.this[*].arn
}

output "listener_arns" {
  description = "ARNs of the listeners"
  value       = aws_lb_listener.this[*].arn
}
