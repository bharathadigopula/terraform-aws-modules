#==============================================================================
# NETWORKING EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "networking"
    },
    var.tags
  )
}

module "alb" {
  source = "../../modules/networking/alb"

  name    = var.alb_name
  vpc_id  = var.alb_vpc_id
  subnets = var.alb_subnets
  tags    = local.tags
}

module "api_gateway" {
  source = "../../modules/networking/api-gateway"

  name = var.api_gateway_name
  tags = local.tags
}

module "cloudfront" {
  source = "../../modules/networking/cloudfront"

  origins                = var.cloudfront_origins
  default_cache_behavior = var.cloudfront_default_cache_behavior
  tags                   = local.tags
}

module "direct_connect" {
  source = "../../modules/networking/direct-connect"

  name = var.direct_connect_name
  tags = local.tags
}

module "elastic_ip" {
  source = "../../modules/networking/elastic-ip"

  name = var.elastic_ip_name
  tags = local.tags
}

module "global_accelerator" {
  source = "../../modules/networking/global-accelerator"

  name = var.global_accelerator_name
  tags = local.tags
}

module "network_firewall" {
  source = "../../modules/networking/network-firewall"

  name           = var.network_firewall_name
  vpc_id         = var.network_firewall_vpc_id
  subnet_mapping = var.network_firewall_subnet_mapping
  tags           = local.tags
}

module "nlb" {
  source = "../../modules/networking/nlb"

  name = var.nlb_name
  tags = local.tags
}

module "privatelink" {
  source = "../../modules/networking/privatelink"

  vpc_id = var.privatelink_vpc_id
  tags   = local.tags
}

module "route53" {
  source = "../../modules/networking/route53"

  zone_name = var.route53_zone_name
  tags      = local.tags
}

module "security_group" {
  source = "../../modules/networking/security-group"

  name   = var.security_group_name
  vpc_id = var.security_group_vpc_id
  tags   = local.tags
}

module "subnet" {
  source = "../../modules/networking/subnet"

  name   = var.subnet_name
  vpc_id = var.subnet_vpc_id
  tags   = local.tags
}

module "transit_gateway" {
  source = "../../modules/networking/transit-gateway"

  name = var.transit_gateway_name
  tags = local.tags
}

module "vpc" {
  source = "../../modules/networking/vpc"

  name       = var.vpc_name
  cidr_block = var.vpc_cidr_block
  tags       = local.tags
}

module "vpc_peering" {
  source = "../../modules/networking/vpc-peering"

  name             = var.vpc_peering_name
  requester_vpc_id = var.vpc_peering_requester_vpc_id
  accepter_vpc_id  = var.vpc_peering_accepter_vpc_id
  tags             = local.tags
}

module "vpn" {
  source = "../../modules/networking/vpn"

  name                        = var.vpn_name
  customer_gateway_bgp_asn    = var.vpn_customer_gateway_bgp_asn
  customer_gateway_ip_address = var.vpn_customer_gateway_ip_address
  tags                        = local.tags
}
