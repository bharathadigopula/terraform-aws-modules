#==============================================================================
# KINESIS DATA STREAM
#==============================================================================
resource "aws_kinesis_stream" "this" {
  name             = var.name
  shard_count      = var.stream_mode == "PROVISIONED" ? var.shard_count : null
  retention_period = var.retention_period

  shard_level_metrics       = var.shard_level_metrics
  enforce_consumer_deletion = var.enforce_consumer_deletion

  encryption_type = var.encryption_type
  kms_key_id      = var.encryption_type == "KMS" ? var.kms_key_id : null

  stream_mode_details {
    stream_mode = var.stream_mode
  }

  tags = var.tags
}

#==============================================================================
# KINESIS CONSUMERS
#==============================================================================
resource "aws_kinesis_stream_consumer" "this" {
  for_each = { for c in var.consumers : c.name => c }

  name       = each.value.name
  stream_arn = aws_kinesis_stream.this.arn
}
