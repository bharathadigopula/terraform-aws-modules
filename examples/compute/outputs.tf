#==============================================================================
# COMPUTE OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "app_runner",
    "auto_scaling_group",
    "batch",
    "ec2",
    "ec2_image_builder",
    "elastic_beanstalk",
    "lambda",
    "launch_template",
    "lightsail",
    "placement_group",
  ]
}
