#==============================================================================
# SAGEMAKER NOTEBOOK IAM ROLES
#==============================================================================

resource "aws_iam_role" "notebook" {
  for_each = { for notebook in var.notebook_instances : notebook.name => notebook if notebook.role_arn == null }

  name                 = each.value.role_name
  name_prefix          = each.value.role_name == null ? "${each.value.name}-" : null
  path                 = each.value.role_path
  permissions_boundary = each.value.role_permissions_boundary
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })
  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# SAGEMAKER NOTEBOOK INSTANCES
#==============================================================================

resource "aws_sagemaker_notebook_instance" "this" {
  for_each = { for notebook in var.notebook_instances : notebook.name => notebook }

  name                         = each.value.name
  role_arn                     = each.value.role_arn != null ? each.value.role_arn : aws_iam_role.notebook[each.key].arn
  instance_type                = each.value.instance_type
  subnet_id                    = each.value.subnet_id
  security_groups              = each.value.security_groups
  kms_key_id                   = each.value.kms_key_id
  lifecycle_config_name        = each.value.lifecycle_config_name
  direct_internet_access       = "Disabled"
  root_access                  = "Disabled"
  volume_size                  = each.value.volume_size
  default_code_repository      = each.value.default_code_repository
  additional_code_repositories = each.value.additional_code_repositories
  platform_identifier          = each.value.platform_identifier
  tags                         = merge(var.tags, each.value.tags)

  instance_metadata_service_configuration {
    minimum_instance_metadata_service_version = "2"
  }
}

#==============================================================================
# SAGEMAKER MODELS
#==============================================================================

resource "aws_sagemaker_model" "this" {
  for_each = { for model in var.models : model.name => model }

  name                     = each.value.name
  execution_role_arn       = each.value.execution_role_arn
  enable_network_isolation = true
  tags                     = merge(var.tags, each.value.tags)

  dynamic "primary_container" {
    for_each = each.value.primary_container != null ? [each.value.primary_container] : []

    content {
      image                        = primary_container.value.image
      model_data_url               = primary_container.value.model_data_url
      model_package_name           = primary_container.value.model_package_name
      container_hostname           = primary_container.value.container_hostname
      environment                  = primary_container.value.environment
      mode                         = primary_container.value.mode
      inference_specification_name = primary_container.value.inference_specification_name
    }
  }

  dynamic "vpc_config" {
    for_each = each.value.vpc_config != null ? [each.value.vpc_config] : []

    content {
      subnets            = vpc_config.value.subnets
      security_group_ids = vpc_config.value.security_group_ids
    }
  }
}

#==============================================================================
# SAGEMAKER ENDPOINT CONFIGURATIONS
#==============================================================================

resource "aws_sagemaker_endpoint_configuration" "this" {
  for_each = { for config in var.endpoint_configurations : config.name => config }

  name               = each.value.name
  name_prefix        = each.value.name_prefix
  kms_key_arn        = each.value.kms_key_arn
  execution_role_arn = each.value.execution_role_arn
  tags               = merge(var.tags, each.value.tags)

  dynamic "production_variants" {
    for_each = each.value.production_variants

    content {
      variant_name                                      = production_variants.value.variant_name
      model_name                                        = try(aws_sagemaker_model.this[production_variants.value.model_name].name, production_variants.value.model_name)
      instance_type                                     = production_variants.value.instance_type
      initial_instance_count                            = production_variants.value.initial_instance_count
      initial_variant_weight                            = production_variants.value.initial_variant_weight
      accelerator_type                                  = production_variants.value.accelerator_type
      container_startup_health_check_timeout_in_seconds = production_variants.value.container_startup_health_check_timeout_in_seconds
      model_data_download_timeout_in_seconds            = production_variants.value.model_data_download_timeout_in_seconds
      enable_ssm_access                                 = production_variants.value.enable_ssm_access
      inference_ami_version                             = production_variants.value.inference_ami_version
      volume_size_in_gb                                 = production_variants.value.volume_size_in_gb

      dynamic "serverless_config" {
        for_each = production_variants.value.serverless_config != null ? [production_variants.value.serverless_config] : []

        content {
          max_concurrency         = serverless_config.value.max_concurrency
          memory_size_in_mb       = serverless_config.value.memory_size_in_mb
          provisioned_concurrency = serverless_config.value.provisioned_concurrency
        }
      }
    }
  }
}

#==============================================================================
# SAGEMAKER ENDPOINTS
#==============================================================================

resource "aws_sagemaker_endpoint" "this" {
  for_each = { for endpoint in var.endpoints : endpoint.name => endpoint }

  name                 = each.value.name
  endpoint_config_name = try(aws_sagemaker_endpoint_configuration.this[each.value.endpoint_config_name].name, each.value.endpoint_config_name)
  tags                 = merge(var.tags, each.value.tags)
}
