#==============================================================================
# FINANCIAL MANAGEMENT EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "financial"
    },
    var.tags
  )
}

module "billing_conductor" {
  source = "../../modules/financial/billing-conductor"

  resources = var.billing_conductor_resources
}

module "budgets" {
  source = "../../modules/financial/budgets"

  budgets = var.budgets
  tags    = local.tags
}

module "cost_anomaly_detection" {
  source = "../../modules/financial/cost-anomaly-detection"

  monitors      = var.cost_anomaly_monitors
  subscriptions = var.cost_anomaly_subscriptions
  tags          = local.tags
}

module "savings_plans" {
  source = "../../modules/financial/savings-plans"

  savings_plans = var.savings_plans
  tags          = local.tags
}
