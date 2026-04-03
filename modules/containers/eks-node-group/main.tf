#==============================================================================
# EKS NODE GROUP
#==============================================================================

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types       = var.instance_types
  capacity_type        = var.capacity_type
  disk_size            = var.launch_template == null ? var.disk_size : null
  ami_type             = var.launch_template == null ? var.ami_type : null
  force_update_version = var.force_update_version
  labels               = var.labels

  #==============================================================================
  # SCALING CONFIGURATION
  #==============================================================================

  scaling_config {
    desired_size = var.scaling_config.desired_size
    min_size     = var.scaling_config.min_size
    max_size     = var.scaling_config.max_size
  }

  #==============================================================================
  # UPDATE CONFIGURATION
  #==============================================================================

  dynamic "update_config" {
    for_each = var.update_config != null ? [var.update_config] : []

    content {
      max_unavailable            = update_config.value.max_unavailable
      max_unavailable_percentage = update_config.value.max_unavailable_percentage
    }
  }

  #==============================================================================
  # LAUNCH TEMPLATE
  #==============================================================================

  dynamic "launch_template" {
    for_each = var.launch_template != null ? [var.launch_template] : []

    content {
      id      = launch_template.value.id
      version = launch_template.value.version
    }
  }

  #==============================================================================
  # REMOTE ACCESS
  #==============================================================================

  dynamic "remote_access" {
    for_each = var.remote_access != null ? [var.remote_access] : []

    content {
      ec2_ssh_key               = remote_access.value.ec2_ssh_key
      source_security_group_ids = remote_access.value.source_security_group_ids
    }
  }

  #==============================================================================
  # TAINTS
  #==============================================================================

  dynamic "taint" {
    for_each = var.taints

    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  tags = var.tags
}
