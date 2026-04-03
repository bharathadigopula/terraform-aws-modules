#==============================================================================
# ECS FARGATE TASK DEFINITION
#==============================================================================
resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  container_definitions    = var.container_definitions

  #==============================================================================
  # RUNTIME PLATFORM
  #==============================================================================
  dynamic "runtime_platform" {
    for_each = var.runtime_platform != null ? [var.runtime_platform] : []

    content {
      cpu_architecture        = runtime_platform.value.cpu_architecture
      operating_system_family = runtime_platform.value.operating_system_family
    }
  }

  #==============================================================================
  # EFS VOLUMES
  #==============================================================================
  dynamic "volume" {
    for_each = var.volumes

    content {
      name = volume.value.name

      efs_volume_configuration {
        file_system_id     = volume.value.efs_volume_configuration.file_system_id
        root_directory     = volume.value.efs_volume_configuration.root_directory
        transit_encryption = volume.value.efs_volume_configuration.transit_encryption

        dynamic "authorization_config" {
          for_each = volume.value.efs_volume_configuration.authorization_config != null ? [volume.value.efs_volume_configuration.authorization_config] : []

          content {
            access_point_id = authorization_config.value.access_point_id
            iam             = authorization_config.value.iam
          }
        }
      }
    }
  }

  #==============================================================================
  # EPHEMERAL STORAGE
  #==============================================================================
  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size_gib != null ? [var.ephemeral_storage_size_gib] : []

    content {
      size_in_gib = ephemeral_storage.value
    }
  }

  tags = var.tags
}
