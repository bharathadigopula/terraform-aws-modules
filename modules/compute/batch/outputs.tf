#==============================================================================
# COMPUTE ENVIRONMENT OUTPUTS
#==============================================================================

output "compute_environment_arn" {
  value       = aws_batch_compute_environment.this.arn
  description = "ARN of the Batch compute environment"
}

output "compute_environment_name" {
  value       = aws_batch_compute_environment.this.name
  description = "Name of the Batch compute environment"
}

#==============================================================================
# JOB QUEUE OUTPUTS
#==============================================================================

output "job_queue_arn" {
  value       = aws_batch_job_queue.this.arn
  description = "ARN of the Batch job queue"
}

output "job_queue_name" {
  value       = aws_batch_job_queue.this.name
  description = "Name of the Batch job queue"
}

#==============================================================================
# JOB DEFINITION OUTPUTS
#==============================================================================

output "job_definition_arns" {
  value       = { for k, v in aws_batch_job_definition.this : k => v.arn }
  description = "Map of job definition names to their ARNs"
}
