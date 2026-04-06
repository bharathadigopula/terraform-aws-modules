#==============================================================================
# Aurora RDS Cluster
#==============================================================================

resource "aws_rds_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  engine             = var.engine
  engine_version     = var.engine_version
  engine_mode        = var.engine_mode

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  port            = var.port

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id

  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  deletion_protection       = var.deletion_protection

  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  apply_immediately                   = var.apply_immediately
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverlessv2_scaling_configuration != null ? [var.serverlessv2_scaling_configuration] : []

    content {
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
    }
  }

  tags = var.tags
}

#==============================================================================
# Aurora Cluster Instances
#==============================================================================

resource "aws_rds_cluster_instance" "this" {
  count = var.instances

  identifier         = "${var.cluster_identifier}-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  engine             = aws_rds_cluster.this.engine
  engine_version     = aws_rds_cluster.this.engine_version
  instance_class     = var.instance_class

  db_subnet_group_name = var.db_subnet_group_name

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  apply_immediately     = var.apply_immediately
  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  tags = var.tags
}
