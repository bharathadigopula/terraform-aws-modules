#==============================================================================
# PLACEMENT GROUP
#==============================================================================

output "placement_group_id" {
  value       = aws_placement_group.this.placement_group_id
  description = "ID of the placement group"
}

output "placement_group_arn" {
  value       = aws_placement_group.this.arn
  description = "ARN of the placement group"
}

output "placement_group_name" {
  value       = aws_placement_group.this.name
  description = "Name of the placement group"
}
