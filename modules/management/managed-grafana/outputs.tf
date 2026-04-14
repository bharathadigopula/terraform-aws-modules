#==============================================================================
# WORKSPACE OUTPUTS
#==============================================================================
output "workspace_id" {
  description = "ID of the Grafana workspace"
  value       = aws_grafana_workspace.this.id
}

output "workspace_arn" {
  description = "ARN of the Grafana workspace"
  value       = aws_grafana_workspace.this.arn
}

output "workspace_endpoint" {
  description = "Endpoint of the Grafana workspace"
  value       = aws_grafana_workspace.this.endpoint
}
