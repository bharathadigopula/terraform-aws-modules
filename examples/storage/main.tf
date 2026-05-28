#==============================================================================
# STORAGE EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "storage"
    },
    var.tags
  )
}

module "backup" {
  source = "../../modules/storage/backup"

  vault_name             = var.backup_vault_name
  kms_key_arn            = var.backup_kms_key_arn
  plan_name              = var.backup_plan_name
  plan_rules             = var.backup_plan_rules
  selection_name         = var.backup_selection_name
  selection_iam_role_arn = var.backup_selection_iam_role_arn
  tags                   = local.tags
}

module "ebs" {
  source = "../../modules/storage/ebs"

  availability_zone = var.ebs_availability_zone
  size              = var.ebs_size
  tags              = local.tags
}

module "efs" {
  source = "../../modules/storage/efs"

  name               = var.efs_name
  subnet_ids         = var.efs_subnet_ids
  security_group_ids = var.efs_security_group_ids
  tags               = local.tags
}

module "fsx_lustre" {
  source = "../../modules/storage/fsx-lustre"

  storage_capacity = var.fsx_lustre_storage_capacity
  subnet_ids       = var.fsx_lustre_subnet_ids
  tags             = local.tags
}

module "fsx_ontap" {
  source = "../../modules/storage/fsx-ontap"

  storage_capacity    = var.fsx_ontap_storage_capacity
  subnet_ids          = var.fsx_ontap_subnet_ids
  throughput_capacity = var.fsx_ontap_throughput_capacity
  preferred_subnet_id = var.fsx_ontap_preferred_subnet_id
  tags                = local.tags
}

module "fsx_openzfs" {
  source = "../../modules/storage/fsx-openzfs"

  storage_capacity    = var.fsx_openzfs_storage_capacity
  subnet_ids          = var.fsx_openzfs_subnet_ids
  throughput_capacity = var.fsx_openzfs_throughput_capacity
  tags                = local.tags
}

module "fsx_windows" {
  source = "../../modules/storage/fsx-windows"

  storage_capacity    = var.fsx_windows_storage_capacity
  subnet_ids          = var.fsx_windows_subnet_ids
  throughput_capacity = var.fsx_windows_throughput_capacity
  tags                = local.tags
}

module "s3" {
  source = "../../modules/storage/s3"

  bucket_name = var.s3_bucket_name
  tags        = local.tags
}

module "s3_replication" {
  source = "../../modules/storage/s3-replication"

  source_bucket_id = var.s3_replication_source_bucket_id
  role_arn         = var.s3_replication_role_arn
  rules            = var.s3_replication_rules
}

module "storage_gateway" {
  source = "../../modules/storage/storage-gateway"

  gateway_name = var.storage_gateway_gateway_name
  tags         = local.tags
}
