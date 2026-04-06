#==============================================================================
# S3 BUCKET REPLICATION CONFIGURATION
#==============================================================================
resource "aws_s3_bucket_replication_configuration" "this" {
  bucket = var.source_bucket_id
  role   = var.role_arn

  dynamic "rule" {
    for_each = var.rules
    content {
      id       = rule.value.id
      status   = rule.value.status
      priority = rule.value.priority

      dynamic "filter" {
        for_each = rule.value.filter != null ? [rule.value.filter] : []
        content {
          prefix = filter.value.prefix

          dynamic "tag" {
            for_each = filter.value.tags != null ? filter.value.tags : {}
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }

      destination {
        bucket        = rule.value.destination.bucket_arn
        storage_class = rule.value.destination.storage_class
        account       = rule.value.destination.account_id

        dynamic "encryption_configuration" {
          for_each = rule.value.destination.replica_kms_key_id != null ? [1] : []
          content {
            replica_kms_key_id = rule.value.destination.replica_kms_key_id
          }
        }
      }

      delete_marker_replication {
        status = rule.value.delete_marker_replication
      }

      existing_object_replication {
        status = rule.value.existing_object_replication
      }
    }
  }
}
