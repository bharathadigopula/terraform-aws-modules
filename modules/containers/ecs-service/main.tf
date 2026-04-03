#==============================================================================
# ECS SERVICE
#==============================================================================
resource "aws_ecs_service" "this" {
  name                               = var.name
  cluster                            = var.cluster_arn
  task_definition                    = var.task_definition_arn
  desired_count                      = var.scheduling_strategy == "DAEMON" ? null : var.desired_count
  launch_type                        = length(var.capacity_provider_strategy) > 0 ? null : var.launch_type
  platform_version                   = var.platform_version
  scheduling_strategy                = var.scheduling_strategy
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  enable_execute_command             = var.enable_execute_command
  force_new_deployment               = var.force_new_deployment
  propagate_tags                     = var.propagate_tags
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags

  #==============================================================================
  # NETWORK CONFIGURATION
  #==============================================================================
  dynamic "network_configuration" {
    for_each = var.network_configuration != null ? [var.network_configuration] : []

    content {
      subnets          = network_configuration.value.subnets
      security_groups  = network_configuration.value.security_groups
      assign_public_ip = network_configuration.value.assign_public_ip
    }
  }

  #==============================================================================
  # LOAD BALANCER
  #==============================================================================
  dynamic "load_balancer" {
    for_each = var.load_balancer

    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  #==============================================================================
  # SERVICE REGISTRIES
  #==============================================================================
  dynamic "service_registries" {
    for_each = var.service_registries != null ? [var.service_registries] : []

    content {
      registry_arn   = service_registries.value.registry_arn
      container_name = service_registries.value.container_name
      container_port = service_registries.value.container_port
    }
  }

  #==============================================================================
  # DEPLOYMENT CIRCUIT BREAKER
  #==============================================================================
  dynamic "deployment_circuit_breaker" {
    for_each = var.deployment_circuit_breaker != null ? [var.deployment_circuit_breaker] : []

    content {
      enable   = deployment_circuit_breaker.value.enable
      rollback = deployment_circuit_breaker.value.rollback
    }
  }

  #==============================================================================
  # ORDERED PLACEMENT STRATEGY
  #==============================================================================
  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy

    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  #==============================================================================
  # CAPACITY PROVIDER STRATEGY
  #==============================================================================
  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_provider_strategy

    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
      base              = capacity_provider_strategy.value.base
    }
  }

  tags = var.tags
}
