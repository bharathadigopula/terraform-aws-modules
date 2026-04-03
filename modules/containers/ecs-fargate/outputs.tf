#==============================================================================
# ECS FARGATE TASK DEFINITION OUTPUTS
#==============================================================================
output "task_definition_arn" {
  description = "Full ARN of the task definition including the revision"
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "Family of the task definition"
  value       = aws_ecs_task_definition.this.family
}

output "task_definition_revision" {
  description = "Revision number of the task definition"
  value       = aws_ecs_task_definition.this.revision
}
