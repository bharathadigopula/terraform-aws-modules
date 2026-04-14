#==============================================================================
# MACIE ACCOUNT
#==============================================================================
resource "aws_macie2_account" "this" {
  finding_publishing_frequency = var.finding_publishing_frequency
  status                       = var.status
}

#==============================================================================
# CLASSIFICATION EXPORT CONFIGURATION
#==============================================================================
resource "aws_macie2_classification_export_configuration" "this" {
  count = var.export_s3_destination != null ? 1 : 0

  s3_destination {
    bucket_name = var.export_s3_destination.bucket_name
    key_prefix  = var.export_s3_destination.key_prefix
    kms_key_arn = var.export_s3_destination.kms_key_arn
  }

  depends_on = [aws_macie2_account.this]
}

#==============================================================================
# CLASSIFICATION JOBS
#==============================================================================
resource "aws_macie2_classification_job" "this" {
  for_each = { for j in var.classification_jobs : j.name => j }

  name                = each.value.name
  job_type            = each.value.job_type
  job_status          = each.value.job_status
  sampling_percentage = each.value.sampling_percentage

  s3_job_definition {
    dynamic "bucket_definitions" {
      for_each = each.value.bucket_definitions
      content {
        account_id = bucket_definitions.value.account_id
        buckets    = bucket_definitions.value.buckets
      }
    }
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_macie2_account.this]
}
