#==============================================================================
# FRONTEND WEB AND MOBILE EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "frontend"
    },
    var.tags
  )
}

module "amplify" {
  source = "../../modules/frontend/amplify"

  apps                = var.amplify_apps
  branches            = var.amplify_branches
  domain_associations = var.amplify_domain_associations
  tags                = local.tags
}

module "appsync" {
  source = "../../modules/frontend/appsync"

  graphql_apis = var.appsync_graphql_apis
  api_keys     = var.appsync_api_keys
  datasources  = var.appsync_datasources
  resolvers    = var.appsync_resolvers
  tags         = local.tags
}

module "location_service" {
  source = "../../modules/frontend/location-service"

  maps                 = var.location_maps
  place_indexes        = var.location_place_indexes
  route_calculators    = var.location_route_calculators
  trackers             = var.location_trackers
  geofence_collections = var.location_geofence_collections
  tags                 = local.tags
}
