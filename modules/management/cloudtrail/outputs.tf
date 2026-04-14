#==============================================================================
# CLOUDTRAIL OUTPUTS
#==============================================================================
output "trail_id" {
  description = "Name of the CloudTrail trail"
  value       = aws_cloudtrail.this.id
}

output "trail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.this.arn
}

output "home_region" {
  description = "Home region of the trail"
  value       = aws_cloudtrail.this.home_region
}
