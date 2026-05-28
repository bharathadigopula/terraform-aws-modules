#==============================================================================
# SECURITY EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "security"
    },
    var.tags
  )
}

module "acm" {
  source = "../../modules/security/acm"

  domain_name = var.acm_domain_name
  tags        = local.tags
}

module "audit_manager" {
  source = "../../modules/security/audit-manager"

  tags = local.tags
}

module "cloudhsm" {
  source = "../../modules/security/cloudhsm"

  subnet_ids = var.cloudhsm_subnet_ids
  tags       = local.tags
}

module "cognito" {
  source = "../../modules/security/cognito"

  name = var.cognito_name
  tags = local.tags
}

module "detective" {
  source = "../../modules/security/detective"

  tags = local.tags
}

module "directory_service" {
  source = "../../modules/security/directory-service"

  name       = var.directory_service_name
  password   = var.directory_service_password
  vpc_id     = var.directory_service_vpc_id
  subnet_ids = var.directory_service_subnet_ids
  tags       = local.tags
}

module "firewall_manager" {
  source = "../../modules/security/firewall-manager"

  tags = local.tags
}

module "guardduty" {
  source = "../../modules/security/guardduty"

  tags = local.tags
}

module "iam" {
  source = "../../modules/security/iam"

  tags = local.tags
}

module "iam_identity_center" {
  source = "../../modules/security/iam-identity-center"

  instance_arn = var.iam_identity_center_instance_arn
  tags         = local.tags
}

module "inspector" {
  source = "../../modules/security/inspector"

  account_ids = var.inspector_account_ids
}

module "kms" {
  source = "../../modules/security/kms"

  tags = local.tags
}

module "macie" {
  source = "../../modules/security/macie"

  tags = local.tags
}

module "ram" {
  source = "../../modules/security/ram"

  name = var.ram_name
  tags = local.tags
}

module "secrets_manager" {
  source = "../../modules/security/secrets-manager"

  name = var.secrets_manager_name
  tags = local.tags
}

module "security_hub" {
  source = "../../modules/security/security-hub"
}

module "security_lake" {
  source = "../../modules/security/security-lake"

  meta_store_manager_role_arn = var.security_lake_meta_store_manager_role_arn
  configurations              = var.security_lake_configurations
  tags                        = local.tags
}

module "shield" {
  source = "../../modules/security/shield"

  tags = local.tags
}

module "verified_permissions" {
  source = "../../modules/security/verified-permissions"
}

module "waf" {
  source = "../../modules/security/waf"

  name = var.waf_name
  tags = local.tags
}
