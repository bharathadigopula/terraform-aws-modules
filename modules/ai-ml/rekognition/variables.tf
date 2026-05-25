#==============================================================================
# REKOGNITION COLLECTION VARIABLES
#==============================================================================

variable "collections" {
  description = "List of Rekognition collections to create"
  type = list(object({
    collection_id = string
    tags          = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# REKOGNITION PROJECT VARIABLES
#==============================================================================

variable "projects" {
  description = "List of Rekognition projects to create"
  type = list(object({
    name        = string
    feature     = optional(string)
    auto_update = optional(string)
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
