#==============================================================================
# LEX OUTPUTS
#==============================================================================

output "bot_ids" {
  description = "Map of Lex bot IDs"
  value       = { for k, v in aws_lexv2models_bot.this : k => v.id }
}

output "bot_arns" {
  description = "Map of Lex bot ARNs"
  value       = { for k, v in aws_lexv2models_bot.this : k => v.arn }
}
