#==============================================================================
# ZONE OUTPUTS
#==============================================================================

output "zone_id" {
  value = try(aws_route53_zone.this[0].zone_id, null)
}

output "zone_arn" {
  value = try(aws_route53_zone.this[0].arn, null)
}

output "zone_name_servers" {
  value = try(aws_route53_zone.this[0].name_servers, [])
}

#==============================================================================
# RECORD OUTPUTS
#==============================================================================

output "record_names" {
  value = [for r in aws_route53_record.this : r.name]
}

output "record_fqdns" {
  value = [for r in aws_route53_record.this : r.fqdn]
}

#==============================================================================
# HEALTH CHECK OUTPUTS
#==============================================================================

output "health_check_ids" {
  value = [for hc in aws_route53_health_check.this : hc.id]
}
