#==============================================================================
# ALB OUTPUTS
#==============================================================================

output "alb_id" {
  value       = aws_lb.this.id
  description = "ID of the Application Load Balancer"
}

output "alb_arn" {
  value       = aws_lb.this.arn
  description = "ARN of the Application Load Balancer"
}

output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "alb_zone_id" {
  value       = aws_lb.this.zone_id
  description = "Canonical hosted zone ID of the ALB for Route53 alias records"
}

#==============================================================================
# TARGET GROUP OUTPUTS
#==============================================================================

output "target_group_arns" {
  value       = aws_lb_target_group.this[*].arn
  description = "ARNs of the target groups"
}

output "target_group_names" {
  value       = aws_lb_target_group.this[*].name
  description = "Names of the target groups"
}

#==============================================================================
# LISTENER OUTPUTS
#==============================================================================

output "listener_arns" {
  value       = aws_lb_listener.this[*].arn
  description = "ARNs of the listeners"
}
