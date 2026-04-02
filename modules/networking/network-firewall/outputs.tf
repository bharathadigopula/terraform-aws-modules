#==============================================================================
# FIREWALL OUTPUTS
#==============================================================================

output "firewall_id" {
  description = "The ID of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.id
}

output "firewall_arn" {
  description = "The ARN of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.arn
}

output "firewall_status" {
  description = "The status of the Network Firewall"
  value       = aws_networkfirewall_firewall.this.firewall_status
}

output "firewall_endpoint_ids" {
  description = "Map of AZ to firewall endpoint IDs for route table configuration"
  value = {
    for ss in aws_networkfirewall_firewall.this.firewall_status[0].sync_states :
    ss.availability_zone => ss.attachment[0].endpoint_id
  }
}

#==============================================================================
# FIREWALL POLICY OUTPUTS
#==============================================================================

output "firewall_policy_id" {
  description = "The ID of the firewall policy"
  value       = aws_networkfirewall_firewall_policy.this.id
}

output "firewall_policy_arn" {
  description = "The ARN of the firewall policy"
  value       = aws_networkfirewall_firewall_policy.this.arn
}

#==============================================================================
# RULE GROUP OUTPUTS
#==============================================================================

output "stateful_rule_group_arns" {
  description = "Map of stateful rule group names to ARNs"
  value       = { for k, v in aws_networkfirewall_rule_group.stateful : k => v.arn }
}

output "stateless_rule_group_arns" {
  description = "Map of stateless rule group names to ARNs"
  value       = { for k, v in aws_networkfirewall_rule_group.stateless : k => v.arn }
}
