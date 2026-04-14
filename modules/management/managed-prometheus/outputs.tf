#==============================================================================
# WORKSPACE OUTPUTS
#==============================================================================
output "workspace_id" {
  description = "ID of the Prometheus workspace"
  value       = aws_prometheus_workspace.this.id
}

output "workspace_arn" {
  description = "ARN of the Prometheus workspace"
  value       = aws_prometheus_workspace.this.arn
}

output "prometheus_endpoint" {
  description = "Prometheus endpoint for remote write"
  value       = aws_prometheus_workspace.this.prometheus_endpoint
}
