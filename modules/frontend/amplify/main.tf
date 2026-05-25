#==============================================================================
# AMPLIFY APPS
#==============================================================================

resource "aws_amplify_app" "this" {
  for_each = { for app in var.apps : app.name => app }

  name                          = each.value.name
  description                   = each.value.description
  repository                    = each.value.repository
  platform                      = each.value.platform
  access_token                  = each.value.access_token
  oauth_token                   = each.value.oauth_token
  build_spec                    = each.value.build_spec
  custom_headers                = each.value.custom_headers
  basic_auth_credentials        = each.value.basic_auth_credentials
  enable_basic_auth             = each.value.enable_basic_auth
  enable_branch_auto_build      = each.value.enable_branch_auto_build
  enable_branch_auto_deletion   = each.value.enable_branch_auto_deletion
  enable_auto_branch_creation   = each.value.enable_auto_branch_creation
  auto_branch_creation_patterns = each.value.auto_branch_creation_patterns
  environment_variables         = each.value.environment_variables
  iam_service_role_arn          = each.value.iam_service_role_arn
  compute_role_arn              = each.value.compute_role_arn
  tags                          = merge(var.tags, each.value.tags)

  dynamic "custom_rule" {
    for_each = each.value.custom_rules

    content {
      source    = custom_rule.value.source
      target    = custom_rule.value.target
      status    = custom_rule.value.status
      condition = custom_rule.value.condition
    }
  }

  dynamic "cache_config" {
    for_each = each.value.cache_config != null ? [each.value.cache_config] : []

    content {
      type = cache_config.value.type
    }
  }
}

#==============================================================================
# AMPLIFY BRANCHES
#==============================================================================

resource "aws_amplify_branch" "this" {
  for_each = { for branch in var.branches : "${branch.app_name}:${branch.branch_name}" => branch }

  app_id                        = each.value.app_name != null ? aws_amplify_app.this[each.value.app_name].id : each.value.app_id
  branch_name                   = each.value.branch_name
  description                   = each.value.description
  display_name                  = each.value.display_name
  framework                     = each.value.framework
  stage                         = each.value.stage
  ttl                           = each.value.ttl
  backend_environment_arn       = each.value.backend_environment_arn
  basic_auth_credentials        = each.value.basic_auth_credentials
  enable_auto_build             = each.value.enable_auto_build
  enable_basic_auth             = each.value.enable_basic_auth
  enable_notification           = each.value.enable_notification
  enable_performance_mode       = each.value.enable_performance_mode
  enable_pull_request_preview   = each.value.enable_pull_request_preview
  enable_skew_protection        = each.value.enable_skew_protection
  environment_variables         = each.value.environment_variables
  pull_request_environment_name = each.value.pull_request_environment_name
  tags                          = merge(var.tags, each.value.tags)
}

#==============================================================================
# AMPLIFY DOMAIN ASSOCIATIONS
#==============================================================================

resource "aws_amplify_domain_association" "this" {
  for_each = { for domain in var.domain_associations : domain.domain_name => domain }

  app_id                 = each.value.app_name != null ? aws_amplify_app.this[each.value.app_name].id : each.value.app_id
  domain_name            = each.value.domain_name
  enable_auto_sub_domain = each.value.enable_auto_sub_domain
  wait_for_verification  = each.value.wait_for_verification

  dynamic "certificate_settings" {
    for_each = each.value.certificate_settings != null ? [each.value.certificate_settings] : []

    content {
      type                   = certificate_settings.value.type
      custom_certificate_arn = certificate_settings.value.custom_certificate_arn
    }
  }

  dynamic "sub_domain" {
    for_each = each.value.sub_domains

    content {
      branch_name = sub_domain.value.branch_name
      prefix      = sub_domain.value.prefix
    }
  }
}
