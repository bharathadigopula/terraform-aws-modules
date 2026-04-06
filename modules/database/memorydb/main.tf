#==============================================================================
# MEMORYDB SUBNET GROUP
#==============================================================================
resource "aws_memorydb_subnet_group" "this" {
  count = length(var.subnet_ids) > 0 ? 1 : 0

  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

#==============================================================================
# MEMORYDB CLUSTER
#==============================================================================
resource "aws_memorydb_cluster" "this" {
  name        = var.name
  description = var.description
  node_type   = var.node_type
  acl_name    = var.acl_name

  num_shards             = var.num_shards
  num_replicas_per_shard = var.num_replicas_per_shard

  subnet_group_name  = length(var.subnet_ids) > 0 ? aws_memorydb_subnet_group.this[0].name : var.subnet_group_name
  security_group_ids = var.security_group_ids
  port               = var.port
  tls_enabled        = var.tls_enabled
  kms_key_arn        = var.kms_key_arn

  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window            = var.snapshot_window
  maintenance_window         = var.maintenance_window
  engine_version             = var.engine_version
  parameter_group_name       = var.parameter_group_name
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  sns_topic_arn              = var.sns_topic_arn

  tags = var.tags
}
