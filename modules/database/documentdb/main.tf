#==============================================================================
# DOCUMENTDB CLUSTER
#==============================================================================

resource "aws_docdb_cluster" "this" {
  cluster_identifier              = var.cluster_identifier
  engine                          = "docdb"
  engine_version                  = var.engine_version
  db_subnet_group_name            = var.db_subnet_group_name
  vpc_security_group_ids          = var.vpc_security_group_ids
  port                            = var.port
  master_username                 = var.master_username
  master_password                 = var.master_password
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_id
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  apply_immediately               = var.apply_immediately
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  tags                            = var.tags
}

#==============================================================================
# DOCUMENTDB CLUSTER INSTANCES
#==============================================================================

resource "aws_docdb_cluster_instance" "this" {
  count = var.instances

  identifier                 = "${var.cluster_identifier}-${count.index}"
  cluster_identifier         = aws_docdb_cluster.this.id
  instance_class             = var.instance_class
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately
  tags                       = var.tags
}
