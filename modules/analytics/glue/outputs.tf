#==============================================================================
# DATABASE OUTPUTS
#==============================================================================
output "database_arns" {
  description = "Map of database names to ARNs"
  value       = { for k, v in aws_glue_catalog_database.this : k => v.arn }
}

#==============================================================================
# CRAWLER OUTPUTS
#==============================================================================
output "crawler_arns" {
  description = "Map of crawler names to ARNs"
  value       = { for k, v in aws_glue_crawler.this : k => v.arn }
}

#==============================================================================
# JOB OUTPUTS
#==============================================================================
output "job_arns" {
  description = "Map of job names to ARNs"
  value       = { for k, v in aws_glue_job.this : k => v.arn }
}

#==============================================================================
# TRIGGER OUTPUTS
#==============================================================================
output "trigger_arns" {
  description = "Map of trigger names to ARNs"
  value       = { for k, v in aws_glue_trigger.this : k => v.arn }
}
