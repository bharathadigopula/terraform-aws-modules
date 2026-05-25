#==============================================================================
# DATASYNC S3 LOCATIONS
#==============================================================================

resource "aws_datasync_location_s3" "this" {
  for_each = { for location in var.s3_locations : location.name => location }

  s3_bucket_arn    = each.value.s3_bucket_arn
  subdirectory     = each.value.subdirectory
  s3_storage_class = each.value.s3_storage_class
  agent_arns       = each.value.agent_arns
  tags             = merge(var.tags, each.value.tags)

  s3_config {
    bucket_access_role_arn = each.value.bucket_access_role_arn
  }
}

#==============================================================================
# DATASYNC TASKS
#==============================================================================

resource "aws_datasync_task" "this" {
  for_each = { for task in var.tasks : task.name => task }

  name                     = each.value.name
  source_location_arn      = each.value.source_location_name != null ? aws_datasync_location_s3.this[each.value.source_location_name].arn : each.value.source_location_arn
  destination_location_arn = each.value.destination_location_name != null ? aws_datasync_location_s3.this[each.value.destination_location_name].arn : each.value.destination_location_arn
  cloudwatch_log_group_arn = each.value.cloudwatch_log_group_arn
  task_mode                = each.value.task_mode
  tags                     = merge(var.tags, each.value.tags)

  dynamic "includes" {
    for_each = each.value.includes != null ? [each.value.includes] : []

    content {
      filter_type = includes.value.filter_type
      value       = includes.value.value
    }
  }

  dynamic "excludes" {
    for_each = each.value.excludes != null ? [each.value.excludes] : []

    content {
      filter_type = excludes.value.filter_type
      value       = excludes.value.value
    }
  }

  dynamic "schedule" {
    for_each = each.value.schedule != null ? [each.value.schedule] : []

    content {
      schedule_expression = schedule.value.schedule_expression
      status              = schedule.value.status
    }
  }

  dynamic "options" {
    for_each = each.value.options != null ? [each.value.options] : []

    content {
      atime                  = options.value.atime
      bytes_per_second       = options.value.bytes_per_second
      gid                    = options.value.gid
      log_level              = options.value.log_level
      mtime                  = options.value.mtime
      object_tags            = options.value.object_tags
      overwrite_mode         = options.value.overwrite_mode
      posix_permissions      = options.value.posix_permissions
      preserve_deleted_files = options.value.preserve_deleted_files
      preserve_devices       = options.value.preserve_devices
      task_queueing          = options.value.task_queueing
      transfer_mode          = options.value.transfer_mode
      uid                    = options.value.uid
      verify_mode            = options.value.verify_mode
    }
  }
}
