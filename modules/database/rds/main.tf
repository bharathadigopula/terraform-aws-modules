#==============================================================================
# RDS Instance
#==============================================================================

resource "aws_db_instance" "this" {
  identifier     = var.identifier
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted
  kms_key_id            = var.kms_key_id

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  multi_az               = var.multi_az
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  parameter_group_name   = var.parameter_group_name
  option_group_name      = var.option_group_name
  publicly_accessible    = var.publicly_accessible

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  deletion_protection        = var.deletion_protection

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = var.performance_insights_retention_period

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  apply_immediately                   = var.apply_immediately

  tags = var.tags
}
