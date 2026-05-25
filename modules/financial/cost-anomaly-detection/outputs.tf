#==============================================================================
# COST ANOMALY OUTPUTS
#==============================================================================

output "monitor_ids" {
  description = "Map of Cost Explorer anomaly monitor IDs"
  value       = { for k, v in aws_ce_anomaly_monitor.this : k => v.id }
}

output "monitor_arns" {
  description = "Map of Cost Explorer anomaly monitor ARNs"
  value       = { for k, v in aws_ce_anomaly_monitor.this : k => v.arn }
}

output "subscription_ids" {
  description = "Map of Cost Explorer anomaly subscription IDs"
  value       = { for k, v in aws_ce_anomaly_subscription.this : k => v.id }
}
