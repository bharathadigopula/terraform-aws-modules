#==============================================================================
# INSPECTOR V2 ENABLER
#==============================================================================
resource "aws_inspector2_enabler" "this" {
  account_ids    = var.account_ids
  resource_types = var.resource_types
}

#==============================================================================
# INSPECTOR ORGANIZATION CONFIGURATION
#==============================================================================
resource "aws_inspector2_organization_configuration" "this" {
  count = var.enable_organization_config ? 1 : 0

  auto_enable {
    ec2         = var.auto_enable_ec2
    ecr         = var.auto_enable_ecr
    lambda      = var.auto_enable_lambda
    lambda_code = var.auto_enable_lambda_code
  }
}
