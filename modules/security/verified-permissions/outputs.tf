#==============================================================================
# VERIFIED PERMISSIONS OUTPUTS
#==============================================================================
output "policy_store_id" {
  description = "ID of the policy store"
  value       = aws_verifiedpermissions_policy_store.this.id
}

output "policy_store_arn" {
  description = "ARN of the policy store"
  value       = aws_verifiedpermissions_policy_store.this.arn
}

output "policy_ids" {
  description = "Map of policy descriptions to IDs"
  value       = { for k, v in aws_verifiedpermissions_policy.static : k => v.id }
}

output "identity_source_ids" {
  description = "Map of identity source user pool ARNs to IDs"
  value       = { for k, v in aws_verifiedpermissions_identity_source.this : k => v.id }
}
