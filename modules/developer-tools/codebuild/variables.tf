#==============================================================================
# CODEBUILD VARIABLES
#==============================================================================

variable "projects" {
  description = "List of CodeBuild projects to create"
  type = list(object({
    name                   = string
    service_role           = string
    description            = optional(string)
    build_timeout          = optional(number)
    queued_timeout         = optional(number)
    badge_enabled          = optional(bool)
    encryption_key         = optional(string)
    source_version         = optional(string)
    concurrent_build_limit = optional(number)
    project_visibility     = optional(string)
    resource_access_role   = optional(string)
    auto_retry_limit       = optional(number)
    artifacts = object({
      type                   = string
      location               = optional(string)
      name                   = optional(string)
      namespace_type         = optional(string)
      packaging              = optional(string)
      path                   = optional(string)
      encryption_disabled    = optional(bool)
      override_artifact_name = optional(bool)
      artifact_identifier    = optional(string)
      bucket_owner_access    = optional(string)
    })
    environment = object({
      compute_type                = string
      image                       = string
      type                        = string
      certificate                 = optional(string)
      image_pull_credentials_type = optional(string)
      privileged_mode             = optional(bool)
      environment_variables = optional(list(object({
        name  = string
        value = string
        type  = optional(string)
      })), [])
    })
    source = object({
      type                = string
      location            = optional(string)
      buildspec           = optional(string)
      git_clone_depth     = optional(number)
      insecure_ssl        = optional(bool)
      report_build_status = optional(bool)
    })
    cache = optional(object({
      type            = optional(string)
      location        = optional(string)
      modes           = optional(list(string))
      cache_namespace = optional(string)
    }))
    vpc_config = optional(object({
      vpc_id             = string
      subnets            = set(string)
      security_group_ids = set(string)
    }))
    logs_config = optional(object({
      cloudwatch_logs = optional(object({
        status      = optional(string)
        group_name  = optional(string)
        stream_name = optional(string)
      }))
      s3_logs = optional(object({
        status              = optional(string)
        location            = optional(string)
        encryption_disabled = optional(bool)
        bucket_owner_access = optional(string)
      }))
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
