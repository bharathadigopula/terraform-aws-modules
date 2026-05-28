#==============================================================================
# MIGRATION AND TRANSFER EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "migration"
    },
    var.tags
  )
}

module "application_migration" {
  source = "../../modules/migration/application-migration"

  resources = var.application_migration_resources
}

module "datasync" {
  source = "../../modules/migration/datasync"

  s3_locations = var.datasync_s3_locations
  tasks        = var.datasync_tasks
  tags         = local.tags
}

module "migration_hub" {
  source = "../../modules/migration/migration-hub"

  resources = var.migration_hub_resources
}

module "snow_family" {
  source = "../../modules/migration/snow-family"

  resources = var.snow_family_resources
}

module "transfer_family" {
  source = "../../modules/migration/transfer-family"

  servers  = var.transfer_family_servers
  users    = var.transfer_family_users
  ssh_keys = var.transfer_family_ssh_keys
  tags     = local.tags
}
