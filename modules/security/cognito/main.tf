#==============================================================================
# COGNITO USER POOL
#==============================================================================
resource "aws_cognito_user_pool" "this" {
  name = var.name

  username_attributes      = var.username_attributes
  auto_verified_attributes = var.auto_verified_attributes
  mfa_configuration        = var.mfa_configuration
  deletion_protection      = var.deletion_protection

  password_policy {
    minimum_length                   = var.password_policy.minimum_length
    require_lowercase                = var.password_policy.require_lowercase
    require_numbers                  = var.password_policy.require_numbers
    require_symbols                  = var.password_policy.require_symbols
    require_uppercase                = var.password_policy.require_uppercase
    temporary_password_validity_days = var.password_policy.temporary_password_validity_days
  }

  dynamic "schema" {
    for_each = var.schema_attributes
    content {
      name                     = schema.value.name
      attribute_data_type      = schema.value.attribute_data_type
      developer_only_attribute = schema.value.developer_only_attribute
      mutable                  = schema.value.mutable
      required                 = schema.value.required

      dynamic "string_attribute_constraints" {
        for_each = schema.value.attribute_data_type == "String" ? [1] : []
        content {
          min_length = schema.value.min_length
          max_length = schema.value.max_length
        }
      }

      dynamic "number_attribute_constraints" {
        for_each = schema.value.attribute_data_type == "Number" ? [1] : []
        content {
          min_value = schema.value.min_value
          max_value = schema.value.max_value
        }
      }
    }
  }

  dynamic "software_token_mfa_configuration" {
    for_each = var.mfa_configuration != "OFF" ? [1] : []
    content {
      enabled = true
    }
  }

  account_recovery_setting {
    dynamic "recovery_mechanism" {
      for_each = var.recovery_mechanisms
      content {
        name     = recovery_mechanism.value.name
        priority = recovery_mechanism.value.priority
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# USER POOL DOMAIN
#==============================================================================
resource "aws_cognito_user_pool_domain" "this" {
  count = var.domain != null ? 1 : 0

  domain          = var.domain
  certificate_arn = var.domain_certificate_arn
  user_pool_id    = aws_cognito_user_pool.this.id
}

#==============================================================================
# USER POOL CLIENTS
#==============================================================================
resource "aws_cognito_user_pool_client" "this" {
  for_each = { for c in var.clients : c.name => c }

  name         = each.value.name
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret                      = each.value.generate_secret
  explicit_auth_flows                  = each.value.explicit_auth_flows
  allowed_oauth_flows                  = each.value.allowed_oauth_flows
  allowed_oauth_flows_user_pool_client = each.value.allowed_oauth_flows_user_pool_client
  allowed_oauth_scopes                 = each.value.allowed_oauth_scopes
  callback_urls                        = each.value.callback_urls
  logout_urls                          = each.value.logout_urls
  supported_identity_providers         = each.value.supported_identity_providers

  access_token_validity  = each.value.access_token_validity
  id_token_validity      = each.value.id_token_validity
  refresh_token_validity = each.value.refresh_token_validity

  prevent_user_existence_errors = each.value.prevent_user_existence_errors
}

#==============================================================================
# RESOURCE SERVERS
#==============================================================================
resource "aws_cognito_resource_server" "this" {
  for_each = { for rs in var.resource_servers : rs.identifier => rs }

  identifier   = each.value.identifier
  name         = each.value.name
  user_pool_id = aws_cognito_user_pool.this.id

  dynamic "scope" {
    for_each = each.value.scopes
    content {
      scope_name        = scope.value.scope_name
      scope_description = scope.value.scope_description
    }
  }
}
