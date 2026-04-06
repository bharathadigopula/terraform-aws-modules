#==============================================================================
# ELASTICACHE REPLICATION GROUP
#==============================================================================

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.replication_group_id
  description          = var.description
  engine               = var.engine
  engine_version       = var.engine_version
  node_type            = var.node_type
  port                 = var.port

  num_cache_clusters      = var.num_cache_nodes
  num_node_groups         = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group

  parameter_group_name = var.parameter_group_name
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = var.security_group_ids

  #==============================================================================
  # ENCRYPTION
  #==============================================================================

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_id                 = var.kms_key_id
  auth_token                 = var.auth_token

  #==============================================================================
  # HIGH AVAILABILITY
  #==============================================================================

  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled

  #==============================================================================
  # BACKUP AND MAINTENANCE
  #==============================================================================

  snapshot_retention_limit  = var.snapshot_retention_limit
  snapshot_window           = var.snapshot_window
  maintenance_window        = var.maintenance_window
  final_snapshot_identifier = var.final_snapshot_identifier

  #==============================================================================
  # NOTIFICATIONS AND UPGRADES
  #==============================================================================

  notification_topic_arn     = var.notification_topic_arn
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  #==============================================================================
  # LOG DELIVERY
  #==============================================================================

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
  }

  tags = var.tags
}
