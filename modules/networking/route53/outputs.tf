#==============================================================================
# ZONE OUTPUTS
#==============================================================================

output "zone_id" {
  description = "The ID of the Route53 hosted zone"
  value       = try(aws_route53_zone.this[0].zone_id, null)
}

output "zone_arn" {
  description = "The ARN of the Route53 hosted zone"
  value       = try(aws_route53_zone.this[0].arn, null)
}

output "zone_name_servers" {
  description = "List of name servers for the Route53 hosted zone"
  value       = try(aws_route53_zone.this[0].name_servers, [])
}

#==============================================================================
# RECORD OUTPUTS
#==============================================================================

output "record_names" {
  description = "List of DNS record names created in the hosted zone"
  value       = [for r in aws_route53_record.this : r.name]
}

output "record_fqdns" {
  description = "List of fully qualified domain names for the DNS records"
  value       = [for r in aws_route53_record.this : r.fqdn]
}

#==============================================================================
# HEALTH CHECK OUTPUTS
#==============================================================================

output "health_check_ids" {
  description = "List of IDs for the Route53 health checks"
  value       = [for hc in aws_route53_health_check.this : hc.id]
}
