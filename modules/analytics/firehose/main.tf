#==============================================================================
# KINESIS FIREHOSE DELIVERY STREAM
#==============================================================================
resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = var.name
  destination = var.destination

  dynamic "server_side_encryption" {
    for_each = var.enable_encryption ? [1] : []
    content {
      enabled  = true
      key_type = var.encryption_key_type
      key_arn  = var.encryption_key_arn
    }
  }

  dynamic "kinesis_source_configuration" {
    for_each = var.kinesis_source_stream_arn != null ? [1] : []
    content {
      kinesis_stream_arn = var.kinesis_source_stream_arn
      role_arn           = var.kinesis_source_role_arn
    }
  }

  dynamic "extended_s3_configuration" {
    for_each = var.destination == "extended_s3" ? [1] : []
    content {
      bucket_arn          = var.s3_bucket_arn
      role_arn            = var.s3_role_arn
      prefix              = var.s3_prefix
      error_output_prefix = var.s3_error_output_prefix
      buffering_size      = var.s3_buffering_size
      buffering_interval  = var.s3_buffering_interval
      compression_format  = var.s3_compression_format
      kms_key_arn         = var.s3_kms_key_arn

      cloudwatch_logging_options {
        enabled         = var.enable_cloudwatch_logging
        log_group_name  = var.cloudwatch_log_group_name
        log_stream_name = var.cloudwatch_log_stream_name
      }
    }
  }

  tags = var.tags
}
