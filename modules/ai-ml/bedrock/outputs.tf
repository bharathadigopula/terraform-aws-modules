#==============================================================================
# BEDROCK OUTPUTS
#==============================================================================

output "guardrail_ids" {
  description = "Map of Bedrock guardrail IDs"
  value       = { for k, v in aws_bedrock_guardrail.this : k => v.guardrail_id }
}

output "guardrail_arns" {
  description = "Map of Bedrock guardrail ARNs"
  value       = { for k, v in aws_bedrock_guardrail.this : k => v.guardrail_arn }
}

output "agent_ids" {
  description = "Map of Bedrock agent IDs"
  value       = { for k, v in aws_bedrockagent_agent.this : k => v.agent_id }
}

output "agent_arns" {
  description = "Map of Bedrock agent ARNs"
  value       = { for k, v in aws_bedrockagent_agent.this : k => v.agent_arn }
}
