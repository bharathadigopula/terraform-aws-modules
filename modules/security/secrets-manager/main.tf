#==============================================================================
# SECRETS MANAGER SECRET
#==============================================================================
resource "aws_secretsmanager_secret" "this" {
  name                           = var.name
  description                    = var.description
  kms_key_id                     = var.kms_key_id
  recovery_window_in_days        = var.recovery_window_in_days
  force_overwrite_replica_secret = var.force_overwrite_replica_secret

  dynamic "replica" {
    for_each = var.replica_regions
    content {
      region     = replica.value.region
      kms_key_id = replica.value.kms_key_id
    }
  }

  tags = var.tags
}

#==============================================================================
# SECRET VERSION
#==============================================================================
resource "aws_secretsmanager_secret_version" "this" {
  count = var.secret_string != null || var.secret_binary != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
  secret_binary = var.secret_binary
}

#==============================================================================
# SECRET ROTATION
#==============================================================================
resource "aws_secretsmanager_secret_rotation" "this" {
  count = var.rotation_lambda_arn != null ? 1 : 0

  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.rotation_rules.automatically_after_days
    duration                 = var.rotation_rules.duration
    schedule_expression      = var.rotation_rules.schedule_expression
  }
}

#==============================================================================
# SECRET POLICY
#==============================================================================
resource "aws_secretsmanager_secret_policy" "this" {
  count = var.policy != null ? 1 : 0

  secret_arn          = aws_secretsmanager_secret.this.arn
  policy              = var.policy
  block_public_policy = var.block_public_policy
}
