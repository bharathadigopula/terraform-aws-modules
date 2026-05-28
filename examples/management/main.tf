#==============================================================================
# MANAGEMENT EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "management"
    },
    var.tags
  )
}

module "cloudtrail" {
  source = "../../modules/management/cloudtrail"

  name           = var.cloudtrail_name
  s3_bucket_name = var.cloudtrail_s3_bucket_name
  tags           = local.tags
}

module "cloudwatch_alarms" {
  source = "../../modules/management/cloudwatch-alarms"

  tags = local.tags
}

module "cloudwatch_dashboard" {
  source = "../../modules/management/cloudwatch-dashboard"
}

module "cloudwatch_logs" {
  source = "../../modules/management/cloudwatch-logs"

  tags = local.tags
}

module "config_rules" {
  source = "../../modules/management/config-rules"

  tags = local.tags
}

module "control_tower" {
  source = "../../modules/management/control-tower"

  tags = local.tags
}

module "health" {
  source = "../../modules/management/health"

  tags = local.tags
}

module "license_manager" {
  source = "../../modules/management/license-manager"

  tags = local.tags
}

module "managed_grafana" {
  source = "../../modules/management/managed-grafana"

  name = var.managed_grafana_name
  tags = local.tags
}

module "managed_prometheus" {
  source = "../../modules/management/managed-prometheus"

  tags = local.tags
}

module "organizations" {
  source = "../../modules/management/organizations"

  tags = local.tags
}

module "service_catalog" {
  source = "../../modules/management/service-catalog"

  tags = local.tags
}

module "systems_manager" {
  source = "../../modules/management/systems-manager"

  tags = local.tags
}

module "trusted_advisor" {
  source = "../../modules/management/trusted-advisor"

  tags = local.tags
}
