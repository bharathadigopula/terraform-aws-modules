#==============================================================================
# EBS VOLUME OUTPUTS
#==============================================================================
output "volume_id" {
  description = "The ID of the EBS volume"
  value       = aws_ebs_volume.this.id
}

output "volume_arn" {
  description = "The ARN of the EBS volume"
  value       = aws_ebs_volume.this.arn
}

output "volume_size" {
  description = "The size of the EBS volume in GiBs"
  value       = aws_ebs_volume.this.size
}

output "volume_type" {
  description = "The type of the EBS volume"
  value       = aws_ebs_volume.this.type
}
