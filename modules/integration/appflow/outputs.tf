#==============================================================================
# FLOW OUTPUTS
#==============================================================================
output "flow_arn" {
  description = "ARN of the AppFlow flow"
  value       = aws_appflow_flow.this.arn
}

output "flow_status" {
  description = "Status of the flow"
  value       = aws_appflow_flow.this.flow_status
}
