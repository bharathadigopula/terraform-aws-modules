#==============================================================================
# MSK CLUSTER
#==============================================================================
resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.client_subnets
    security_groups = var.security_groups

    storage_info {
      ebs_storage_info {
        volume_size = var.broker_volume_size
      }
    }

    connectivity_info {
      public_access {
        type = var.public_access_type
      }
    }
  }

  dynamic "encryption_info" {
    for_each = var.kms_key_arn != null || var.encryption_in_transit_client_broker != null ? [1] : []
    content {
      encryption_at_rest_kms_key_arn = var.kms_key_arn

      dynamic "encryption_in_transit" {
        for_each = var.encryption_in_transit_client_broker != null ? [1] : []
        content {
          client_broker = var.encryption_in_transit_client_broker
          in_cluster    = var.encryption_in_transit_in_cluster
        }
      }
    }
  }

  dynamic "client_authentication" {
    for_each = var.enable_sasl_iam || var.enable_sasl_scram || var.enable_tls ? [1] : []
    content {
      dynamic "sasl" {
        for_each = var.enable_sasl_iam || var.enable_sasl_scram ? [1] : []
        content {
          iam   = var.enable_sasl_iam
          scram = var.enable_sasl_scram
        }
      }
      dynamic "tls" {
        for_each = var.enable_tls ? [1] : []
        content {
          certificate_authority_arns = var.tls_certificate_authority_arns
        }
      }
    }
  }

  dynamic "logging_info" {
    for_each = var.enable_cloudwatch_logs || var.enable_firehose_logs || var.enable_s3_logs ? [1] : []
    content {
      broker_logs {
        dynamic "cloudwatch_logs" {
          for_each = var.enable_cloudwatch_logs ? [1] : []
          content {
            enabled   = true
            log_group = var.cloudwatch_log_group
          }
        }
        dynamic "firehose" {
          for_each = var.enable_firehose_logs ? [1] : []
          content {
            enabled         = true
            delivery_stream = var.firehose_delivery_stream
          }
        }
        dynamic "s3" {
          for_each = var.enable_s3_logs ? [1] : []
          content {
            enabled = true
            bucket  = var.s3_log_bucket
            prefix  = var.s3_log_prefix
          }
        }
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# MSK CONFIGURATION
#==============================================================================
resource "aws_msk_configuration" "this" {
  count = var.server_properties != null ? 1 : 0

  name              = "${var.cluster_name}-config"
  kafka_versions    = [var.kafka_version]
  server_properties = var.server_properties
}
