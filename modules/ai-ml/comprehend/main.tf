#==============================================================================
# COMPREHEND DOCUMENT CLASSIFIERS
#==============================================================================

resource "aws_comprehend_document_classifier" "this" {
  for_each = { for classifier in var.document_classifiers : classifier.name => classifier }

  name                 = each.value.name
  data_access_role_arn = each.value.data_access_role_arn
  language_code        = each.value.language_code
  mode                 = each.value.mode
  version_name         = each.value.version_name
  version_name_prefix  = each.value.version_name_prefix
  model_kms_key_id     = each.value.model_kms_key_id
  volume_kms_key_id    = each.value.volume_kms_key_id
  tags                 = merge(var.tags, each.value.tags)

  input_data_config {
    data_format     = each.value.input_data_config.data_format
    label_delimiter = each.value.input_data_config.label_delimiter
    s3_uri          = each.value.input_data_config.s3_uri
    test_s3_uri     = each.value.input_data_config.test_s3_uri
  }

  dynamic "output_data_config" {
    for_each = each.value.output_data_config != null ? [each.value.output_data_config] : []

    content {
      s3_uri     = output_data_config.value.s3_uri
      kms_key_id = output_data_config.value.kms_key_id
    }
  }

  dynamic "vpc_config" {
    for_each = each.value.vpc_config != null ? [each.value.vpc_config] : []

    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
    }
  }
}
