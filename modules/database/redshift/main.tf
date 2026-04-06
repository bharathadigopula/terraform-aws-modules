#==============================================================================
# AMAZON REDSHIFT CLUSTER
#==============================================================================

resource "aws_redshift_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  node_type          = var.node_type
  number_of_nodes    = var.number_of_nodes
  cluster_type       = var.number_of_nodes > 1 ? "multi-node" : "single-node"

  database_name   = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  port            = var.port

  #==============================================================================
  # NETWORK CONFIGURATION
  #==============================================================================

  cluster_subnet_group_name = var.cluster_subnet_group_name
  vpc_security_group_ids    = var.vpc_security_group_ids
  publicly_accessible       = var.publicly_accessible
  enhanced_vpc_routing      = var.enhanced_vpc_routing
  elastic_ip                = var.elastic_ip

  #==============================================================================
  # ENCRYPTION CONFIGURATION
  #==============================================================================

  encrypted  = var.encrypted
  kms_key_id = var.encrypted ? var.kms_key_id : null

  #==============================================================================
  # PARAMETER GROUP AND IAM
  #==============================================================================

  cluster_parameter_group_name = var.cluster_parameter_group_name
  iam_roles                    = var.iam_roles

  #==============================================================================
  # SNAPSHOT CONFIGURATION
  #==============================================================================

  skip_final_snapshot                 = var.skip_final_snapshot
  final_snapshot_identifier           = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  automated_snapshot_retention_period = var.automated_snapshot_retention_period

  #==============================================================================
  # MAINTENANCE CONFIGURATION
  #==============================================================================

  preferred_maintenance_window = var.preferred_maintenance_window

  tags = var.tags
}

#==============================================================================
# REDSHIFT LOGGING
#==============================================================================

resource "aws_redshift_logging" "this" {
  count = var.logging != null ? 1 : 0

  cluster_identifier   = aws_redshift_cluster.this.id
  log_destination_type = var.logging.log_destination_type
  bucket_name          = var.logging.bucket_name
  s3_key_prefix        = var.logging.s3_key_prefix
}
