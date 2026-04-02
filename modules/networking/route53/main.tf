#==============================================================================
# LOCALS
#==============================================================================

locals {
  is_private_zone = length(var.vpc_associations) > 0

  records_map = {
    for idx, record in var.records : "${record.name}-${record.type}-${coalesce(record.set_identifier, idx)}" => record
  }

  health_checks_map = {
    for idx, hc in var.health_checks : "${hc.fqdn}-${hc.type}-${idx}" => hc
  }
}

#==============================================================================
# ROUTE53 HOSTED ZONE
#==============================================================================

resource "aws_route53_zone" "this" {
  count = var.create_zone ? 1 : 0

  name              = var.zone_name
  comment           = var.comment
  force_destroy     = var.force_destroy
  delegation_set_id = local.is_private_zone ? null : var.delegation_set_id

  dynamic "vpc" {
    for_each = var.vpc_associations

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = var.tags
}

#==============================================================================
# ROUTE53 RECORDS
#==============================================================================

resource "aws_route53_record" "this" {
  for_each = var.create_zone ? local.records_map : {}

  zone_id = aws_route53_zone.this[0].zone_id
  name    = each.value.name
  type    = each.value.type

  ttl     = each.value.alias == null ? each.value.ttl : null
  records = each.value.alias == null ? each.value.records : null

  set_identifier  = each.value.set_identifier
  health_check_id = each.value.health_check_id

  dynamic "alias" {
    for_each = each.value.alias != null ? [each.value.alias] : []

    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = each.value.weighted_routing_policy != null ? [each.value.weighted_routing_policy] : []

    content {
      weight = weighted_routing_policy.value.weight
    }
  }

  dynamic "latency_routing_policy" {
    for_each = each.value.latency_routing_policy != null ? [each.value.latency_routing_policy] : []

    content {
      region = latency_routing_policy.value.region
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.failover_routing_policy != null ? [each.value.failover_routing_policy] : []

    content {
      type = failover_routing_policy.value.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = each.value.geolocation_routing_policy != null ? [each.value.geolocation_routing_policy] : []

    content {
      continent   = geolocation_routing_policy.value.continent
      country     = geolocation_routing_policy.value.country
      subdivision = geolocation_routing_policy.value.subdivision
    }
  }
}

#==============================================================================
# ROUTE53 HEALTH CHECKS
#==============================================================================

resource "aws_route53_health_check" "this" {
  for_each = local.health_checks_map

  fqdn              = each.value.fqdn
  port               = each.value.port
  type               = each.value.search_string != null ? "${each.value.type}_STR_MATCH" : each.value.type
  resource_path      = each.value.resource_path
  failure_threshold  = each.value.failure_threshold
  request_interval   = each.value.request_interval
  search_string      = each.value.search_string

  tags = merge(var.tags, {
    Name = each.value.fqdn
  })
}
