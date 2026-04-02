#==============================================================================
# EC2 INSTANCES
#==============================================================================

resource "aws_instance" "this" {
  count = var.instance_count

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone

  user_data        = var.user_data
  user_data_base64 = var.user_data_base64

  monitoring    = var.monitoring
  ebs_optimized = var.ebs_optimized

  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  tenancy = var.tenancy
  host_id = var.host_id

  #==============================================================================
  # METADATA OPTIONS
  #==============================================================================

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  #==============================================================================
  # ROOT BLOCK DEVICE
  #==============================================================================

  dynamic "root_block_device" {
    for_each = var.root_block_device != null ? [var.root_block_device] : []

    content {
      volume_type           = root_block_device.value.volume_type
      volume_size           = root_block_device.value.volume_size
      iops                  = root_block_device.value.iops
      throughput            = root_block_device.value.throughput
      encrypted             = root_block_device.value.encrypted
      kms_key_id            = root_block_device.value.kms_key_id
      delete_on_termination = root_block_device.value.delete_on_termination
    }
  }

  #==============================================================================
  # ADDITIONAL EBS BLOCK DEVICES
  #==============================================================================

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices

    content {
      device_name           = ebs_block_device.value.device_name
      volume_type           = ebs_block_device.value.volume_type
      volume_size           = ebs_block_device.value.volume_size
      iops                  = ebs_block_device.value.iops
      throughput            = ebs_block_device.value.throughput
      encrypted             = ebs_block_device.value.encrypted
      kms_key_id            = ebs_block_device.value.kms_key_id
      delete_on_termination = ebs_block_device.value.delete_on_termination
      snapshot_id           = ebs_block_device.value.snapshot_id
    }
  }

  #==============================================================================
  # CREDIT SPECIFICATION FOR BURSTABLE INSTANCES
  #==============================================================================

  dynamic "credit_specification" {
    for_each = var.cpu_credits != null ? [var.cpu_credits] : []

    content {
      cpu_credits = credit_specification.value
    }
  }

  tags = merge(var.tags, {
    Name = var.instance_count > 1 ? "${var.name}-${count.index}" : var.name
  })

  lifecycle {
    ignore_changes = [ami, user_data, user_data_base64]
  }
}
