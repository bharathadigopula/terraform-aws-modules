#==============================================================================
# IMAGE RECIPE
#==============================================================================

resource "aws_imagebuilder_image_recipe" "this" {
  name         = var.name
  description  = var.description
  parent_image = var.parent_image
  version      = var.version

  dynamic "component" {
    for_each = var.components
    content {
      component_arn = component.value.component_arn
    }
  }

  tags = var.tags
}

#==============================================================================
# INFRASTRUCTURE CONFIGURATION
#==============================================================================

resource "aws_imagebuilder_infrastructure_configuration" "this" {
  name                          = var.name
  description                   = var.description
  instance_types                = var.instance_types
  instance_profile_name         = var.iam_instance_profile_name
  subnet_id                     = var.subnet_id
  security_group_ids            = var.security_group_ids
  key_pair                      = var.key_pair
  terminate_instance_on_failure = var.terminate_instance_on_failure

  tags = var.tags
}

#==============================================================================
# DISTRIBUTION CONFIGURATION
#==============================================================================

resource "aws_imagebuilder_distribution_configuration" "this" {
  name        = var.name
  description = var.description

  dynamic "distribution" {
    for_each = var.distribution_regions
    content {
      region = distribution.value.region

      ami_distribution_configuration {
        name       = distribution.value.ami_name
        kms_key_id = var.kms_key_id
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# IMAGE PIPELINE
#==============================================================================

resource "aws_imagebuilder_image_pipeline" "this" {
  name                             = var.name
  description                      = var.description
  image_recipe_arn                 = aws_imagebuilder_image_recipe.this.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.this.arn

  dynamic "schedule" {
    for_each = var.schedule != null ? [var.schedule] : []
    content {
      schedule_expression                = schedule.value.schedule_expression
      pipeline_execution_start_condition = schedule.value.pipeline_execution_start_condition
      timezone                           = schedule.value.timezone
    }
  }

  tags = var.tags
}
