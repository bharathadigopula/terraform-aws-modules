#==============================================================================
# FINANCIAL MANAGEMENT OUTPUTS
#==============================================================================

output "modules" {
  description = "Outputs from the financial management modules"
  value = {
    billing_conductor      = module.billing_conductor
    budgets                = module.budgets
    cost_anomaly_detection = module.cost_anomaly_detection
    savings_plans          = module.savings_plans
  }
}
