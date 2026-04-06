#==============================================================================
# EFS FILE SYSTEM
#==============================================================================
resource "aws_efs_file_system" "this" {
  encrypted                       = var.encrypted
  kms_key_id                      = var.kms_key_id
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps

  dynamic "lifecycle_policy" {
    for_each = var.lifecycle_policy
    content {
      transition_to_ia                    = lifecycle_policy.value.transition_to_ia
      transition_to_primary_storage_class = lifecycle_policy.value.transition_to_primary_storage_class
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

#==============================================================================
# EFS MOUNT TARGETS
#==============================================================================
resource "aws_efs_mount_target" "this" {
  count = length(var.subnet_ids)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_group_ids
}

#==============================================================================
# EFS ACCESS POINTS
#==============================================================================
locals {
  access_points_map = { for ap in var.access_points : ap.name => ap }
}

resource "aws_efs_access_point" "this" {
  for_each = local.access_points_map

  file_system_id = aws_efs_file_system.this.id

  dynamic "root_directory" {
    for_each = each.value.root_directory_path != null ? [1] : []
    content {
      path = each.value.root_directory_path

      dynamic "creation_info" {
        for_each = each.value.root_directory_creation_info != null ? [each.value.root_directory_creation_info] : []
        content {
          owner_gid   = creation_info.value.owner_gid
          owner_uid   = creation_info.value.owner_uid
          permissions = creation_info.value.permissions
        }
      }
    }
  }

  dynamic "posix_user" {
    for_each = each.value.posix_user != null ? [each.value.posix_user] : []
    content {
      gid            = posix_user.value.gid
      uid            = posix_user.value.uid
      secondary_gids = posix_user.value.secondary_gids
    }
  }

  tags = merge(var.tags, {
    Name = each.key
  })
}

#==============================================================================
# EFS FILE SYSTEM POLICY
#==============================================================================
resource "aws_efs_file_system_policy" "this" {
  count = var.file_system_policy != null ? 1 : 0

  file_system_id = aws_efs_file_system.this.id
  policy         = var.file_system_policy
}

#==============================================================================
# EFS BACKUP POLICY
#==============================================================================
resource "aws_efs_backup_policy" "this" {
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = var.backup_policy_status
  }
}
