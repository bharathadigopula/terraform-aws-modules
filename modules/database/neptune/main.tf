#==============================================================================
# NEPTUNE CLUSTER
#==============================================================================
resource "aws_neptune_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  engine             = "neptune"
  engine_version     = var.engine_version

  neptune_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids       = var.vpc_security_group_ids
  port                         = var.port
  storage_encrypted            = var.storage_encrypted
  kms_key_arn                  = var.kms_key_id
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  skip_final_snapshot          = var.skip_final_snapshot
  deletion_protection          = var.deletion_protection
  apply_immediately            = var.apply_immediately
  copy_tags_to_snapshot        = true

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  enable_cloudwatch_logs_exports      = var.enable_cloudwatch_logs_exports

  tags = var.tags
}

#==============================================================================
# NEPTUNE CLUSTER INSTANCES
#==============================================================================
resource "aws_neptune_cluster_instance" "this" {
  count = var.instances

  identifier         = "${var.cluster_identifier}-${count.index}"
  cluster_identifier = aws_neptune_cluster.this.id
  instance_class     = var.instance_class
  engine             = "neptune"

  neptune_subnet_group_name  = var.db_subnet_group_name
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  tags = var.tags
}
