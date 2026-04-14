#==============================================================================
# DETECTIVE OUTPUTS
#==============================================================================
output "graph_arn" {
  description = "ARN of the Detective graph"
  value       = aws_detective_graph.this.graph_arn
}

output "graph_id" {
  description = "ID of the Detective graph"
  value       = aws_detective_graph.this.id
}
