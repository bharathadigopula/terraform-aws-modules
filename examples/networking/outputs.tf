#==============================================================================
# NETWORKING OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "alb",
    "api_gateway",
    "cloudfront",
    "direct_connect",
    "elastic_ip",
    "global_accelerator",
    "network_firewall",
    "nlb",
    "privatelink",
    "route53",
    "security_group",
    "subnet",
    "transit_gateway",
    "vpc",
    "vpc_peering",
    "vpn",
  ]
}
