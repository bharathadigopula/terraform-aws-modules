#==============================================================================
# COMPREHEND OUTPUTS
#==============================================================================

output "document_classifier_ids" {
  description = "Map of Comprehend document classifier IDs"
  value       = { for k, v in aws_comprehend_document_classifier.this : k => v.id }
}

output "document_classifier_arns" {
  description = "Map of Comprehend document classifier ARNs"
  value       = { for k, v in aws_comprehend_document_classifier.this : k => v.arn }
}
