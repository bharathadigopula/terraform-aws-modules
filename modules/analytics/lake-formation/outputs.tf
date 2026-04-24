#==============================================================================
# DATA LAKE SETTINGS OUTPUTS
#==============================================================================
output "data_lake_settings_id" {
  description = "ID of the data lake settings"
  value       = aws_lakeformation_data_lake_settings.this.id
}

#==============================================================================
# RESOURCE OUTPUTS
#==============================================================================
output "resource_arns" {
  description = "Map of registered resource ARNs"
  value       = { for k, v in aws_lakeformation_resource.this : k => v.arn }
}
