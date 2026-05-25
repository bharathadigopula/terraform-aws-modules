#==============================================================================
# CODEBUILD PROJECTS
#==============================================================================

resource "aws_codebuild_project" "this" {
  for_each = { for project in var.projects : project.name => project }

  name                   = each.value.name
  service_role           = each.value.service_role
  description            = each.value.description
  build_timeout          = each.value.build_timeout
  queued_timeout         = each.value.queued_timeout
  badge_enabled          = each.value.badge_enabled
  encryption_key         = each.value.encryption_key
  source_version         = each.value.source_version
  concurrent_build_limit = each.value.concurrent_build_limit
  project_visibility     = each.value.project_visibility
  resource_access_role   = each.value.resource_access_role
  auto_retry_limit       = each.value.auto_retry_limit
  tags                   = merge(var.tags, each.value.tags)

  artifacts {
    type                   = each.value.artifacts.type
    location               = each.value.artifacts.location
    name                   = each.value.artifacts.name
    namespace_type         = each.value.artifacts.namespace_type
    packaging              = each.value.artifacts.packaging
    path                   = each.value.artifacts.path
    encryption_disabled    = each.value.artifacts.encryption_disabled
    override_artifact_name = each.value.artifacts.override_artifact_name
    artifact_identifier    = each.value.artifacts.artifact_identifier
    bucket_owner_access    = each.value.artifacts.bucket_owner_access
  }

  environment {
    compute_type                = each.value.environment.compute_type
    image                       = each.value.environment.image
    type                        = each.value.environment.type
    certificate                 = each.value.environment.certificate
    image_pull_credentials_type = each.value.environment.image_pull_credentials_type
    privileged_mode             = each.value.environment.privileged_mode

    dynamic "environment_variable" {
      for_each = each.value.environment.environment_variables

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source {
    type                = each.value.source.type
    location            = each.value.source.location
    buildspec           = each.value.source.buildspec
    git_clone_depth     = each.value.source.git_clone_depth
    insecure_ssl        = each.value.source.insecure_ssl
    report_build_status = each.value.source.report_build_status
  }

  dynamic "cache" {
    for_each = each.value.cache != null ? [each.value.cache] : []

    content {
      type            = cache.value.type
      location        = cache.value.location
      modes           = cache.value.modes
      cache_namespace = cache.value.cache_namespace
    }
  }

  dynamic "vpc_config" {
    for_each = each.value.vpc_config != null ? [each.value.vpc_config] : []

    content {
      vpc_id             = vpc_config.value.vpc_id
      subnets            = vpc_config.value.subnets
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  dynamic "logs_config" {
    for_each = each.value.logs_config != null ? [each.value.logs_config] : []

    content {
      dynamic "cloudwatch_logs" {
        for_each = logs_config.value.cloudwatch_logs != null ? [logs_config.value.cloudwatch_logs] : []

        content {
          status      = cloudwatch_logs.value.status
          group_name  = cloudwatch_logs.value.group_name
          stream_name = cloudwatch_logs.value.stream_name
        }
      }

      dynamic "s3_logs" {
        for_each = logs_config.value.s3_logs != null ? [logs_config.value.s3_logs] : []

        content {
          status              = s3_logs.value.status
          location            = s3_logs.value.location
          encryption_disabled = s3_logs.value.encryption_disabled
          bucket_owner_access = s3_logs.value.bucket_owner_access
        }
      }
    }
  }
}
