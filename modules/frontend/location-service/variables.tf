#==============================================================================
# LOCATION SERVICE MAP VARIABLES
#==============================================================================

variable "maps" {
  description = "List of Location Service maps to create"
  type = list(object({
    name        = string
    style       = string
    description = optional(string)
    tags        = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# LOCATION SERVICE PLACE INDEX VARIABLES
#==============================================================================

variable "place_indexes" {
  description = "List of Location Service place indexes to create"
  type = list(object({
    name         = string
    data_source  = string
    intended_use = optional(string)
    description  = optional(string)
    tags         = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# LOCATION SERVICE ROUTE CALCULATOR VARIABLES
#==============================================================================

variable "route_calculators" {
  description = "List of Location Service route calculators to create"
  type = list(object({
    name        = string
    data_source = string
    description = optional(string)
    tags        = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# LOCATION SERVICE TRACKER VARIABLES
#==============================================================================

variable "trackers" {
  description = "List of Location Service trackers to create"
  type = list(object({
    name               = string
    description        = optional(string)
    kms_key_id         = optional(string)
    position_filtering = optional(string)
    tags               = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# LOCATION SERVICE GEOFENCE COLLECTION VARIABLES
#==============================================================================

variable "geofence_collections" {
  description = "List of Location Service geofence collections to create"
  type = list(object({
    name        = string
    description = optional(string)
    kms_key_id  = optional(string)
    tags        = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
