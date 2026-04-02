#==============================================================================
# AUTO SCALING GROUP OUTPUTS
#==============================================================================

output "asg_id" {
  value       = aws_autoscaling_group.this.id
  description = "ID of the Auto Scaling Group"
}

output "asg_arn" {
  value       = aws_autoscaling_group.this.arn
  description = "ARN of the Auto Scaling Group"
}

output "asg_name" {
  value       = aws_autoscaling_group.this.name
  description = "Name of the Auto Scaling Group"
}

output "scaling_policy_arns" {
  value       = aws_autoscaling_policy.this[*].arn
  description = "List of ARNs of the scaling policies"
}

output "scheduled_action_arns" {
  value       = aws_autoscaling_schedule.this[*].arn
  description = "List of ARNs of the scheduled actions"
}
