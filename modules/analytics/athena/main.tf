#==============================================================================
# ATHENA WORKGROUP
#==============================================================================
resource "aws_athena_workgroup" "this" {
  name          = var.workgroup_name
  description   = var.description
  state         = var.state
  force_destroy = var.force_destroy

  configuration {
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled
    bytes_scanned_cutoff_per_query     = var.bytes_scanned_cutoff_per_query
    requester_pays_enabled             = var.requester_pays_enabled

    result_configuration {
      output_location = var.output_location

      dynamic "encryption_configuration" {
        for_each = var.encryption_option != null ? [1] : []
        content {
          encryption_option = var.encryption_option
          kms_key_arn       = var.kms_key_arn
        }
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# ATHENA DATABASE
#==============================================================================
resource "aws_athena_database" "this" {
  for_each = { for db in var.databases : db.name => db }

  name          = each.value.name
  bucket        = each.value.bucket
  force_destroy = each.value.force_destroy
  comment       = each.value.comment

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_option != null ? [1] : []
    content {
      encryption_option = each.value.encryption_option
      kms_key           = each.value.kms_key
    }
  }
}

#==============================================================================
# ATHENA NAMED QUERY
#==============================================================================
resource "aws_athena_named_query" "this" {
  for_each = { for q in var.named_queries : q.name => q }

  name        = each.value.name
  workgroup   = aws_athena_workgroup.this.id
  database    = each.value.database
  query       = each.value.query
  description = each.value.description
}
