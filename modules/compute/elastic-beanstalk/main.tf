#==============================================================================
# ELASTIC BEANSTALK APPLICATION
#==============================================================================

resource "aws_elastic_beanstalk_application" "this" {
  name        = var.name
  description = var.description
  tags        = var.tags
}

#==============================================================================
# LOCAL VALUES
#==============================================================================

locals {
  env_var_settings = [
    for k, v in var.environment_variables : {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = k
      value     = v
    }
  ]

  default_settings = [
    {
      namespace = "aws:ec2:vpc"
      name      = "VPCId"
      value     = var.vpc_id
    },
    {
      namespace = "aws:ec2:vpc"
      name      = "Subnets"
      value     = join(",", var.subnets)
    },
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "InstanceType"
      value     = var.instance_type
    },
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "IamInstanceProfile"
      value     = var.iam_instance_profile
    },
    {
      namespace = "aws:elasticbeanstalk:environment"
      name      = "ServiceRole"
      value     = var.service_role
    },
    {
      namespace = "aws:autoscaling:asg"
      name      = "MinSize"
      value     = tostring(var.min_size)
    },
    {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = tostring(var.max_size)
    },
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "EC2KeyName"
      value     = var.key_name
    },
    {
      namespace = "aws:elasticbeanstalk:environment"
      name      = "EnvironmentType"
      value     = var.max_size > 1 ? "LoadBalanced" : "SingleInstance"
    },
    {
      namespace = "aws:elasticbeanstalk:managedactions"
      name      = "ManagedActionsEnabled"
      value     = "true"
    },
    {
      namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
      name      = "UpdateLevel"
      value     = "minor"
    },
    {
      namespace = "aws:elasticbeanstalk:managedactions"
      name      = "PreferredStartTime"
      value     = "Sun:02:00"
    },
    {
      namespace = "aws:elasticbeanstalk:healthreporting:system"
      name      = "SystemType"
      value     = "enhanced"
    },
  ]

  all_settings = concat(local.default_settings, local.env_var_settings, var.settings)
}

#==============================================================================
# ELASTIC BEANSTALK ENVIRONMENT
#==============================================================================

resource "aws_elastic_beanstalk_environment" "this" {
  name                = var.name
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier

  dynamic "setting" {
    for_each = local.all_settings

    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
    }
  }

  tags = var.tags
}
