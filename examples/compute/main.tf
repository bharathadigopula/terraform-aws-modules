#==============================================================================
# COMPUTE EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "compute"
    },
    var.tags
  )
}

module "app_runner" {
  source = "../../modules/compute/app-runner"

  service_name = var.app_runner_service_name
  source_type  = var.app_runner_source_type
  tags         = local.tags
}

module "auto_scaling_group" {
  source = "../../modules/compute/auto-scaling-group"

  name                = var.auto_scaling_group_name
  min_size            = var.auto_scaling_group_min_size
  max_size            = var.auto_scaling_group_max_size
  desired_capacity    = var.auto_scaling_group_desired_capacity
  vpc_zone_identifier = var.auto_scaling_group_vpc_zone_identifier
  launch_template_id  = var.auto_scaling_group_launch_template_id
  tags                = local.tags
}

module "batch" {
  source = "../../modules/compute/batch"

  name           = var.batch_name
  service_role   = var.batch_service_role
  job_queue_name = var.batch_job_queue_name
  tags           = local.tags
}

module "ec2" {
  source = "../../modules/compute/ec2"

  name      = var.ec2_name
  ami       = var.ec2_ami
  subnet_id = var.ec2_subnet_id
  tags      = local.tags
}

module "ec2_image_builder" {
  source = "../../modules/compute/ec2-image-builder"

  name                      = var.ec2_image_builder_name
  parent_image              = var.ec2_image_builder_parent_image
  recipe_version            = var.ec2_image_builder_recipe_version
  instance_types            = var.ec2_image_builder_instance_types
  subnet_id                 = var.ec2_image_builder_subnet_id
  security_group_ids        = var.ec2_image_builder_security_group_ids
  iam_instance_profile_name = var.ec2_image_builder_iam_instance_profile_name
  components                = var.ec2_image_builder_components
  distribution_regions      = var.ec2_image_builder_distribution_regions
  tags                      = local.tags
}

module "elastic_beanstalk" {
  source = "../../modules/compute/elastic-beanstalk"

  name                 = var.elastic_beanstalk_name
  solution_stack_name  = var.elastic_beanstalk_solution_stack_name
  vpc_id               = var.elastic_beanstalk_vpc_id
  subnets              = var.elastic_beanstalk_subnets
  iam_instance_profile = var.elastic_beanstalk_iam_instance_profile
  service_role         = var.elastic_beanstalk_service_role
  tags                 = local.tags
}

module "lambda" {
  source = "../../modules/compute/lambda"

  function_name = var.lambda_function_name
  tags          = local.tags
}

module "launch_template" {
  source = "../../modules/compute/launch-template"

  name = var.launch_template_name
  tags = local.tags
}

module "lightsail" {
  source = "../../modules/compute/lightsail"

  name              = var.lightsail_name
  availability_zone = var.lightsail_availability_zone
  blueprint_id      = var.lightsail_blueprint_id
  bundle_id         = var.lightsail_bundle_id
  tags              = local.tags
}

module "placement_group" {
  source = "../../modules/compute/placement-group"

  name     = var.placement_group_name
  strategy = var.placement_group_strategy
  tags     = local.tags
}
