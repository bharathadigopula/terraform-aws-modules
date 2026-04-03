#==============================================================================
# ECS SERVICE OUTPUTS
#==============================================================================
output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.this.id
}

output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.this.arn
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}
