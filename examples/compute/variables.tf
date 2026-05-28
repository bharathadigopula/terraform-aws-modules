#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# APP RUNNER VARIABLES
#==============================================================================

variable "app_runner_service_name" {
  description = "Value for the service_name input of the app-runner module"
  type        = any
}

variable "app_runner_source_type" {
  description = "Value for the source_type input of the app-runner module"
  type        = any
}

#==============================================================================
# AUTO SCALING GROUP VARIABLES
#==============================================================================

variable "auto_scaling_group_name" {
  description = "Value for the name input of the auto-scaling-group module"
  type        = any
}

variable "auto_scaling_group_min_size" {
  description = "Value for the min_size input of the auto-scaling-group module"
  type        = any
}

variable "auto_scaling_group_max_size" {
  description = "Value for the max_size input of the auto-scaling-group module"
  type        = any
}

variable "auto_scaling_group_desired_capacity" {
  description = "Value for the desired_capacity input of the auto-scaling-group module"
  type        = any
}

variable "auto_scaling_group_vpc_zone_identifier" {
  description = "Value for the vpc_zone_identifier input of the auto-scaling-group module"
  type        = any
}

variable "auto_scaling_group_launch_template_id" {
  description = "Value for the launch_template_id input of the auto-scaling-group module"
  type        = any
}

#==============================================================================
# BATCH VARIABLES
#==============================================================================

variable "batch_name" {
  description = "Value for the name input of the batch module"
  type        = any
}

variable "batch_service_role" {
  description = "Value for the service_role input of the batch module"
  type        = any
}

variable "batch_job_queue_name" {
  description = "Value for the job_queue_name input of the batch module"
  type        = any
}

#==============================================================================
# EC2 VARIABLES
#==============================================================================

variable "ec2_name" {
  description = "Value for the name input of the ec2 module"
  type        = any
}

variable "ec2_ami" {
  description = "Value for the ami input of the ec2 module"
  type        = any
}

variable "ec2_subnet_id" {
  description = "Value for the subnet_id input of the ec2 module"
  type        = any
}

#==============================================================================
# EC2 IMAGE BUILDER VARIABLES
#==============================================================================

variable "ec2_image_builder_name" {
  description = "Value for the name input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_parent_image" {
  description = "Value for the parent_image input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_recipe_version" {
  description = "Value for the recipe_version input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_instance_types" {
  description = "Value for the instance_types input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_subnet_id" {
  description = "Value for the subnet_id input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_security_group_ids" {
  description = "Value for the security_group_ids input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_iam_instance_profile_name" {
  description = "Value for the iam_instance_profile_name input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_components" {
  description = "Value for the components input of the ec2-image-builder module"
  type        = any
}

variable "ec2_image_builder_distribution_regions" {
  description = "Value for the distribution_regions input of the ec2-image-builder module"
  type        = any
}

#==============================================================================
# ELASTIC BEANSTALK VARIABLES
#==============================================================================

variable "elastic_beanstalk_name" {
  description = "Value for the name input of the elastic-beanstalk module"
  type        = any
}

variable "elastic_beanstalk_solution_stack_name" {
  description = "Value for the solution_stack_name input of the elastic-beanstalk module"
  type        = any
}

variable "elastic_beanstalk_vpc_id" {
  description = "Value for the vpc_id input of the elastic-beanstalk module"
  type        = any
}

variable "elastic_beanstalk_subnets" {
  description = "Value for the subnets input of the elastic-beanstalk module"
  type        = any
}

variable "elastic_beanstalk_iam_instance_profile" {
  description = "Value for the iam_instance_profile input of the elastic-beanstalk module"
  type        = any
}

variable "elastic_beanstalk_service_role" {
  description = "Value for the service_role input of the elastic-beanstalk module"
  type        = any
}

#==============================================================================
# LAMBDA VARIABLES
#==============================================================================

variable "lambda_function_name" {
  description = "Value for the function_name input of the lambda module"
  type        = any
}

#==============================================================================
# LAUNCH TEMPLATE VARIABLES
#==============================================================================

variable "launch_template_name" {
  description = "Value for the name input of the launch-template module"
  type        = any
}

#==============================================================================
# LIGHTSAIL VARIABLES
#==============================================================================

variable "lightsail_name" {
  description = "Value for the name input of the lightsail module"
  type        = any
}

variable "lightsail_availability_zone" {
  description = "Value for the availability_zone input of the lightsail module"
  type        = any
}

variable "lightsail_blueprint_id" {
  description = "Value for the blueprint_id input of the lightsail module"
  type        = any
}

variable "lightsail_bundle_id" {
  description = "Value for the bundle_id input of the lightsail module"
  type        = any
}

#==============================================================================
# PLACEMENT GROUP VARIABLES
#==============================================================================

variable "placement_group_name" {
  description = "Value for the name input of the placement-group module"
  type        = any
}

variable "placement_group_strategy" {
  description = "Value for the strategy input of the placement-group module"
  type        = any
}
