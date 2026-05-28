#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# AMPLIFY VARIABLES
#==============================================================================

variable "amplify_apps" {
  description = "Amplify apps to create"
  type        = list(any)
  default     = []
}

variable "amplify_branches" {
  description = "Amplify branches to create"
  type        = list(any)
  default     = []
}

variable "amplify_domain_associations" {
  description = "Amplify domain associations to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# APPSYNC VARIABLES
#==============================================================================

variable "appsync_graphql_apis" {
  description = "AppSync GraphQL APIs to create"
  type        = list(any)
  default     = []
}

variable "appsync_api_keys" {
  description = "AppSync API keys to create"
  type        = list(any)
  default     = []
}

variable "appsync_datasources" {
  description = "AppSync data sources to create"
  type        = list(any)
  default     = []
}

variable "appsync_resolvers" {
  description = "AppSync resolvers to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# LOCATION SERVICE VARIABLES
#==============================================================================

variable "location_maps" {
  description = "Location Service maps to create"
  type        = list(any)
  default     = []
}

variable "location_place_indexes" {
  description = "Location Service place indexes to create"
  type        = list(any)
  default     = []
}

variable "location_route_calculators" {
  description = "Location Service route calculators to create"
  type        = list(any)
  default     = []
}

variable "location_trackers" {
  description = "Location Service trackers to create"
  type        = list(any)
  default     = []
}

variable "location_geofence_collections" {
  description = "Location Service geofence collections to create"
  type        = list(any)
  default     = []
}
