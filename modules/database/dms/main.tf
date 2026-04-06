#==============================================================================
# Locals
#==============================================================================
locals {
  source_endpoints_map = { for ep in var.source_endpoints : ep.endpoint_id => ep }
  target_endpoints_map = { for ep in var.target_endpoints : ep.endpoint_id => ep }
  tasks_map            = { for t in var.tasks : t.task_id => t }

  replication_subnet_group_id = length(var.subnet_ids) > 0 ? aws_dms_replication_subnet_group.this[0].replication_subnet_group_id : var.replication_subnet_group_id
}

#==============================================================================
# DMS Replication Subnet Group
#==============================================================================
resource "aws_dms_replication_subnet_group" "this" {
  count = length(var.subnet_ids) > 0 ? 1 : 0

  replication_subnet_group_id          = "${var.replication_instance_id}-subnet-group"
  replication_subnet_group_description = "Subnet group for DMS replication instance ${var.replication_instance_id}"
  subnet_ids                           = var.subnet_ids

  tags = var.tags
}

#==============================================================================
# DMS Replication Instance
#==============================================================================
resource "aws_dms_replication_instance" "this" {
  replication_instance_id     = var.replication_instance_id
  replication_instance_class  = var.replication_instance_class
  allocated_storage           = var.allocated_storage
  vpc_security_group_ids      = var.vpc_security_group_ids
  replication_subnet_group_id = local.replication_subnet_group_id
  multi_az                    = var.multi_az
  publicly_accessible         = var.publicly_accessible
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  kms_key_arn                 = var.kms_key_arn
  engine_version              = var.engine_version

  tags = var.tags

  depends_on = [aws_dms_replication_subnet_group.this]
}

#==============================================================================
# DMS Source Endpoints
#==============================================================================
resource "aws_dms_endpoint" "source" {
  for_each = local.source_endpoints_map

  endpoint_id                 = each.value.endpoint_id
  endpoint_type               = "source"
  engine_name                 = each.value.engine_name
  server_name                 = each.value.server_name
  port                        = each.value.port
  database_name               = each.value.database_name
  username                    = each.value.username
  password                    = each.value.password
  ssl_mode                    = each.value.ssl_mode
  extra_connection_attributes = each.value.extra_connection_attributes
  kms_key_arn                 = each.value.kms_key_arn

  tags = var.tags
}

#==============================================================================
# DMS Target Endpoints
#==============================================================================
resource "aws_dms_endpoint" "target" {
  for_each = local.target_endpoints_map

  endpoint_id                 = each.value.endpoint_id
  endpoint_type               = "target"
  engine_name                 = each.value.engine_name
  server_name                 = each.value.server_name
  port                        = each.value.port
  database_name               = each.value.database_name
  username                    = each.value.username
  password                    = each.value.password
  ssl_mode                    = each.value.ssl_mode
  extra_connection_attributes = each.value.extra_connection_attributes
  kms_key_arn                 = each.value.kms_key_arn

  tags = var.tags
}

#==============================================================================
# DMS Replication Tasks
#==============================================================================
resource "aws_dms_replication_task" "this" {
  for_each = local.tasks_map

  replication_task_id       = each.value.task_id
  replication_instance_arn  = aws_dms_replication_instance.this.replication_instance_arn
  source_endpoint_arn       = each.value.source_endpoint_arn
  target_endpoint_arn       = each.value.target_endpoint_arn
  migration_type            = each.value.migration_type
  table_mappings            = each.value.table_mappings_json
  replication_task_settings = each.value.replication_task_settings_json

  tags = var.tags
}
