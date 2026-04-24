#==============================================================================
# QUICKSIGHT ACCOUNT SUBSCRIPTION
#==============================================================================
resource "aws_quicksight_account_subscription" "this" {
  count = var.create_subscription ? 1 : 0

  account_name          = var.account_name
  authentication_method = var.authentication_method
  edition               = var.edition
  notification_email    = var.notification_email

  aws_account_id        = var.aws_account_id
  active_directory_name = var.active_directory_name
  admin_group           = var.admin_group
  author_group          = var.author_group
  reader_group          = var.reader_group
  contact_number        = var.contact_number
  directory_id          = var.directory_id
  email_address         = var.email_address
  first_name            = var.first_name
  last_name             = var.last_name
  realm                 = var.realm
}

#==============================================================================
# QUICKSIGHT USER
#==============================================================================
resource "aws_quicksight_user" "this" {
  for_each = { for u in var.users : u.user_name => u }

  user_name     = each.value.user_name
  email         = each.value.email
  identity_type = each.value.identity_type
  user_role     = each.value.user_role
  namespace     = each.value.namespace
  session_name  = each.value.session_name
  iam_arn       = each.value.iam_arn
}

#==============================================================================
# QUICKSIGHT DATA SOURCE
#==============================================================================
resource "aws_quicksight_data_source" "this" {
  for_each = { for ds in var.data_sources : ds.data_source_id => ds }

  data_source_id = each.value.data_source_id
  name           = each.value.name
  type           = each.value.type

  dynamic "parameters" {
    for_each = each.value.parameters != null ? [each.value.parameters] : []
    content {
      dynamic "s3" {
        for_each = each.value.type == "S3" ? [parameters.value.s3] : []
        content {
          manifest_file_location {
            bucket = s3.value.manifest_bucket
            key    = s3.value.manifest_key
          }
        }
      }
    }
  }

  tags = merge(var.tags, each.value.tags)
}
