#==============================================================================
# PIPELINE VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Data Pipeline"
  type        = string
}

variable "description" {
  description = "Description of the pipeline"
  type        = string
  default     = "Managed by Terraform"
}

#==============================================================================
# DEFINITION VARIABLES
#==============================================================================
variable "pipeline_objects" {
  description = "List of pipeline objects"
  type = list(object({
    id   = string
    name = string
    fields = list(object({
      key          = string
      string_value = optional(string)
      ref_value    = optional(string)
    }))
  }))
  default = []
}

variable "parameter_objects" {
  description = "List of parameter objects"
  type = list(object({
    id = string
    attributes = list(object({
      key          = string
      string_value = string
    }))
  }))
  default = []
}

variable "parameter_values" {
  description = "List of parameter values"
  type = list(object({
    id           = string
    string_value = string
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
