#==============================================================================
# BATCH COMPUTE ENVIRONMENT
#==============================================================================

resource "aws_batch_compute_environment" "this" {
  name = var.name
  type                     = var.compute_environment_type
  state                    = var.state
  service_role             = var.service_role

  dynamic "compute_resources" {
    for_each = var.compute_resources != null ? [var.compute_resources] : []

    content {
      type                = compute_resources.value.type
      min_vcpus           = compute_resources.value.min_vcpus
      max_vcpus           = compute_resources.value.max_vcpus
      desired_vcpus       = compute_resources.value.desired_vcpus
      instance_type       = compute_resources.value.instance_types
      subnets             = compute_resources.value.subnets
      security_group_ids  = compute_resources.value.security_group_ids
      instance_role       = compute_resources.value.instance_role
      allocation_strategy = compute_resources.value.allocation_strategy
      bid_percentage      = compute_resources.value.bid_percentage
      ec2_key_pair        = compute_resources.value.ec2_key_pair

      dynamic "launch_template" {
        for_each = compute_resources.value.launch_template_id != null ? [1] : []

        content {
          launch_template_id = compute_resources.value.launch_template_id
        }
      }

      tags = compute_resources.value.tags
    }
  }

  tags = var.tags
}

#==============================================================================
# BATCH JOB QUEUE
#==============================================================================

resource "aws_batch_job_queue" "this" {
  name     = var.job_queue_name
  state    = var.job_queue_state
  priority = var.job_queue_priority

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.this.arn
  }

  tags = var.tags
}

#==============================================================================
# BATCH JOB DEFINITIONS
#==============================================================================

locals {
  job_definitions_map = { for jd in var.job_definitions : jd.name => jd }
}

resource "aws_batch_job_definition" "this" {
  for_each = local.job_definitions_map

  name                 = each.value.name
  type                 = each.value.type
  container_properties = each.value.container_properties_json

  dynamic "timeout" {
    for_each = each.value.timeout_seconds != null ? [each.value.timeout_seconds] : []

    content {
      attempt_duration_seconds = timeout.value
    }
  }

  dynamic "retry_strategy" {
    for_each = each.value.retry_attempts != null ? [each.value.retry_attempts] : []

    content {
      attempts = retry_strategy.value
    }
  }

  tags = var.tags
}
