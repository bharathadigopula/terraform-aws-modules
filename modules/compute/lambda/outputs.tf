#==============================================================================
# LAMBDA FUNCTION OUTPUTS
#==============================================================================

output "function_name" {
  value       = aws_lambda_function.this.function_name
  description = "Name of the Lambda function"
}

output "function_arn" {
  value       = aws_lambda_function.this.arn
  description = "ARN of the Lambda function"
}

output "invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "Invoke ARN of the Lambda function"
}

output "qualified_arn" {
  value       = aws_lambda_function.this.qualified_arn
  description = "Qualified ARN of the Lambda function including version"
}

output "version" {
  value       = aws_lambda_function.this.version
  description = "Latest published version of the Lambda function"
}

#==============================================================================
# IAM ROLE OUTPUTS
#==============================================================================

output "role_arn" {
  value       = var.create_role ? aws_iam_role.lambda[0].arn : var.role_arn
  description = "ARN of the IAM role attached to the Lambda function"
}

output "role_name" {
  value       = var.create_role ? aws_iam_role.lambda[0].name : null
  description = "Name of the IAM role attached to the Lambda function"
}

#==============================================================================
# CLOUDWATCH LOG GROUP OUTPUTS
#==============================================================================

output "log_group_name" {
  value       = aws_cloudwatch_log_group.this.name
  description = "Name of the CloudWatch log group"
}

output "log_group_arn" {
  value       = aws_cloudwatch_log_group.this.arn
  description = "ARN of the CloudWatch log group"
}
