#==============================================================================
# PIPELINE OUTPUTS
#==============================================================================
output "pipeline_id" {
  description = "ID of the Data Pipeline"
  value       = aws_datapipeline_pipeline.this.id
}

output "pipeline_name" {
  description = "Name of the Data Pipeline"
  value       = aws_datapipeline_pipeline.this.name
}
