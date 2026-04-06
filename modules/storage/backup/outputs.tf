#==============================================================================
# BACKUP VAULT OUTPUTS
#==============================================================================
output "vault_id" {
  description = "ID of the AWS Backup vault"
  value       = aws_backup_vault.this.id
}

output "vault_arn" {
  description = "ARN of the AWS Backup vault"
  value       = aws_backup_vault.this.arn
}

#==============================================================================
# BACKUP PLAN OUTPUTS
#==============================================================================
output "plan_id" {
  description = "ID of the AWS Backup plan"
  value       = aws_backup_plan.this.id
}

output "plan_arn" {
  description = "ARN of the AWS Backup plan"
  value       = aws_backup_plan.this.arn
}

#==============================================================================
# BACKUP SELECTION OUTPUTS
#==============================================================================
output "selection_id" {
  description = "ID of the AWS Backup selection"
  value       = aws_backup_selection.this.id
}
