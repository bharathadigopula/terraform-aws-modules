#==============================================================================
# OPENSEARCH DOMAIN
#==============================================================================
resource "aws_opensearch_domain" "this" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    zone_awareness_enabled   = var.zone_awareness_enabled
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_enabled ? var.dedicated_master_type : null
    dedicated_master_count   = var.dedicated_master_enabled ? var.dedicated_master_count : null
    warm_enabled             = var.warm_enabled
    warm_type                = var.warm_enabled ? var.warm_type : null
    warm_count               = var.warm_enabled ? var.warm_count : null

    dynamic "zone_awareness_config" {
      for_each = var.zone_awareness_enabled ? [1] : []
      content {
        availability_zone_count = var.availability_zone_count
      }
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = var.volume_iops
    throughput  = var.volume_throughput
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = var.kms_key_id
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https                   = true
    tls_security_policy             = var.tls_security_policy
    custom_endpoint_enabled         = var.custom_endpoint_enabled
    custom_endpoint                 = var.custom_endpoint
    custom_endpoint_certificate_arn = var.custom_endpoint_certificate_arn
  }

  dynamic "vpc_options" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  dynamic "advanced_security_options" {
    for_each = var.enable_fine_grained_access_control ? [1] : []
    content {
      enabled                        = true
      internal_user_database_enabled = var.internal_user_database_enabled
      anonymous_auth_enabled         = false

      dynamic "master_user_options" {
        for_each = var.master_user_name != null ? [1] : []
        content {
          master_user_arn      = var.master_user_arn
          master_user_name     = var.master_user_name
          master_user_password = var.master_user_password
        }
      }
    }
  }

  dynamic "log_publishing_options" {
    for_each = var.log_publishing_options
    content {
      log_type                 = log_publishing_options.value.log_type
      cloudwatch_log_group_arn = log_publishing_options.value.cloudwatch_log_group_arn
      enabled                  = log_publishing_options.value.enabled
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  access_policies = var.access_policies

  tags = var.tags
}
