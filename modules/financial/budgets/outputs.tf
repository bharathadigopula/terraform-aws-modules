#==============================================================================
# BUDGET OUTPUTS
#==============================================================================

output "budget_ids" {
  description = "Map of AWS Budget IDs"
  value       = { for k, v in aws_budgets_budget.this : k => v.id }
}

output "budget_arns" {
  description = "Map of AWS Budget ARNs"
  value       = { for k, v in aws_budgets_budget.this : k => v.arn }
}

output "budget_names" {
  description = "Map of AWS Budget names"
  value       = { for k, v in aws_budgets_budget.this : k => v.name }
}
