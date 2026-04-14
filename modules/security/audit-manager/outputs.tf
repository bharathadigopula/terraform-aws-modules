#==============================================================================
# AUDIT MANAGER OUTPUTS
#==============================================================================
output "framework_ids" {
  description = "Map of framework names to IDs"
  value       = { for k, v in aws_auditmanager_framework.this : k => v.id }
}

output "framework_arns" {
  description = "Map of framework names to ARNs"
  value       = { for k, v in aws_auditmanager_framework.this : k => v.arn }
}

output "assessment_ids" {
  description = "Map of assessment names to IDs"
  value       = { for k, v in aws_auditmanager_assessment.this : k => v.id }
}

output "assessment_arns" {
  description = "Map of assessment names to ARNs"
  value       = { for k, v in aws_auditmanager_assessment.this : k => v.arn }
}
