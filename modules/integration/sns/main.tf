#==============================================================================
# SNS TOPIC
#==============================================================================
resource "aws_sns_topic" "this" {
  name                        = var.name
  display_name                = var.display_name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  kms_master_key_id = var.kms_master_key_id
  policy            = var.policy

  delivery_policy   = var.delivery_policy
  tracing_config    = var.tracing_config
  signature_version = var.signature_version

  tags = var.tags
}

#==============================================================================
# SNS SUBSCRIPTIONS
#==============================================================================
resource "aws_sns_topic_subscription" "this" {
  for_each = { for s in var.subscriptions : "${s.protocol}-${s.endpoint}" => s }

  topic_arn            = aws_sns_topic.this.arn
  protocol             = each.value.protocol
  endpoint             = each.value.endpoint
  filter_policy        = each.value.filter_policy
  filter_policy_scope  = each.value.filter_policy_scope
  raw_message_delivery = each.value.raw_message_delivery
  redrive_policy       = each.value.redrive_policy
}
