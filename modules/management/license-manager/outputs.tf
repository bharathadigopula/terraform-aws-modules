#==============================================================================
# LICENSE CONFIGURATION OUTPUTS
#==============================================================================
output "license_configuration_arns" {
  description = "Map of license configuration names to ARNs"
  value       = { for k, v in aws_licensemanager_license_configuration.this : k => v.arn }
}

output "license_configuration_ids" {
  description = "Map of license configuration names to IDs"
  value       = { for k, v in aws_licensemanager_license_configuration.this : k => v.id }
}
