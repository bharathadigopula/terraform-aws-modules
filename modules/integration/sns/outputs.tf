#==============================================================================
# TOPIC OUTPUTS
#==============================================================================
output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "topic_id" {
  description = "ID of the SNS topic"
  value       = aws_sns_topic.this.id
}

output "topic_name" {
  description = "Name of the SNS topic"
  value       = aws_sns_topic.this.name
}

#==============================================================================
# SUBSCRIPTION OUTPUTS
#==============================================================================
output "subscription_arns" {
  description = "Map of subscription keys to ARNs"
  value       = { for k, v in aws_sns_topic_subscription.this : k => v.arn }
}
