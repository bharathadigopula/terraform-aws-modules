#==============================================================================
# REKOGNITION OUTPUTS
#==============================================================================

output "collection_ids" {
  description = "Map of Rekognition collection IDs"
  value       = { for k, v in aws_rekognition_collection.this : k => v.id }
}

output "collection_arns" {
  description = "Map of Rekognition collection ARNs"
  value       = { for k, v in aws_rekognition_collection.this : k => v.arn }
}

output "project_arns" {
  description = "Map of Rekognition project ARNs"
  value       = { for k, v in aws_rekognition_project.this : k => v.arn }
}
