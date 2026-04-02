#==============================================================================
# AWS LAUNCH TEMPLATE
#==============================================================================

resource "aws_launch_template" "this" {
  name                                 = var.name
  description                          = var.description
  image_id                             = var.image_id
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  vpc_security_group_ids               = length(var.vpc_security_group_ids) > 0 ? var.vpc_security_group_ids : null
  user_data                            = var.user_data
  ebs_optimized                        = var.ebs_optimized
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  update_default_version               = var.update_default_version

  #==============================================================================
  # IAM INSTANCE PROFILE
  #==============================================================================

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile_name != null || var.iam_instance_profile_arn != null ? [1] : []
    content {
      name = var.iam_instance_profile_name
      arn  = var.iam_instance_profile_arn
    }
  }

  #==============================================================================
  # BLOCK DEVICE MAPPINGS
  #==============================================================================

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name

      ebs {
        volume_size           = block_device_mappings.value.ebs.volume_size
        volume_type           = block_device_mappings.value.ebs.volume_type
        iops                  = block_device_mappings.value.ebs.iops
        throughput            = block_device_mappings.value.ebs.throughput
        encrypted             = block_device_mappings.value.ebs.encrypted
        kms_key_id            = block_device_mappings.value.ebs.kms_key_id
        delete_on_termination = block_device_mappings.value.ebs.delete_on_termination
        snapshot_id           = block_device_mappings.value.ebs.snapshot_id
      }
    }
  }

  #==============================================================================
  # NETWORK INTERFACES
  #==============================================================================

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      device_index                = network_interfaces.value.device_index
      associate_public_ip_address = network_interfaces.value.associate_public_ip_address
      subnet_id                   = network_interfaces.value.subnet_id
      security_groups             = network_interfaces.value.security_groups
      delete_on_termination       = network_interfaces.value.delete_on_termination
    }
  }

  #==============================================================================
  # MONITORING
  #==============================================================================

  monitoring {
    enabled = var.monitoring_enabled
  }

  #==============================================================================
  # PLACEMENT
  #==============================================================================

  dynamic "placement" {
    for_each = var.placement != null ? [var.placement] : []
    content {
      availability_zone = placement.value.availability_zone
      group_name        = placement.value.group_name
      tenancy           = placement.value.tenancy
    }
  }

  #==============================================================================
  # CREDIT SPECIFICATION
  #==============================================================================

  dynamic "credit_specification" {
    for_each = var.credit_specification != null ? [var.credit_specification] : []
    content {
      cpu_credits = credit_specification.value.cpu_credits
    }
  }

  #==============================================================================
  # METADATA OPTIONS
  #==============================================================================

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      http_endpoint               = metadata_options.value.http_endpoint
      http_tokens                 = metadata_options.value.http_tokens
      http_put_response_hop_limit = metadata_options.value.http_put_response_hop_limit
      instance_metadata_tags      = metadata_options.value.instance_metadata_tags
    }
  }

  #==============================================================================
  # TAG SPECIFICATIONS
  #==============================================================================

  dynamic "tag_specifications" {
    for_each = var.tag_specifications
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  tags = var.tags
}
