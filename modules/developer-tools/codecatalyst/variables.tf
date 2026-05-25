#==============================================================================
# CODECATALYST PROJECT VARIABLES
#==============================================================================

variable "projects" {
  description = "List of CodeCatalyst projects to create"
  type = list(object({
    name         = string
    space_name   = string
    display_name = string
    description  = optional(string)
  }))
  default = []
}

#==============================================================================
# CODECATALYST SOURCE REPOSITORY VARIABLES
#==============================================================================

variable "source_repositories" {
  description = "List of CodeCatalyst source repositories to create"
  type = list(object({
    name         = string
    space_name   = string
    project_name = string
    description  = optional(string)
  }))
  default = []
}

#==============================================================================
# CODECATALYST DEV ENVIRONMENT VARIABLES
#==============================================================================

variable "dev_environments" {
  description = "List of CodeCatalyst dev environments to create"
  type = list(object({
    name                       = string
    space_name                 = string
    project_name               = string
    instance_type              = string
    persistent_storage_size    = number
    alias                      = optional(string)
    inactivity_timeout_minutes = optional(number)
    ide = object({
      name    = optional(string)
      runtime = optional(string)
    })
    repositories = optional(list(object({
      repository_name = string
      branch_name     = optional(string)
    })), [])
  }))
  default = []
}
