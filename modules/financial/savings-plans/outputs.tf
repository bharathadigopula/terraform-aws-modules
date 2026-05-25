#==============================================================================
# SAVINGS PLAN OUTPUTS
#==============================================================================

output "savings_plan_ids" {
  description = "Map of Savings Plan IDs"
  value       = { for k, v in aws_savingsplans_savings_plan.this : k => v.savings_plan_id }
}

output "savings_plan_arns" {
  description = "Map of Savings Plan ARNs"
  value       = { for k, v in aws_savingsplans_savings_plan.this : k => v.savings_plan_arn }
}

output "savings_plan_states" {
  description = "Map of Savings Plan states"
  value       = { for k, v in aws_savingsplans_savings_plan.this : k => v.state }
}
