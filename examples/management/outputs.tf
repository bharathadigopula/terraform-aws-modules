#==============================================================================
# MANAGEMENT OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "cloudtrail",
    "cloudwatch_alarms",
    "cloudwatch_dashboard",
    "cloudwatch_logs",
    "config_rules",
    "control_tower",
    "health",
    "license_manager",
    "managed_grafana",
    "managed_prometheus",
    "organizations",
    "service_catalog",
    "systems_manager",
    "trusted_advisor",
  ]
}
