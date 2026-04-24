#==============================================================================
# DATABASE VARIABLES
#==============================================================================
variable "databases" {
  description = "List of Glue catalog databases"
  type = list(object({
    name         = string
    description  = optional(string, "Managed by Terraform")
    location_uri = optional(string)
    parameters   = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# CRAWLER VARIABLES
#==============================================================================
variable "crawlers" {
  description = "List of Glue crawlers"
  type = list(object({
    name          = string
    description   = optional(string, "Managed by Terraform")
    database_name = string
    role_arn      = string
    schedule      = optional(string)
    table_prefix  = optional(string)
    s3_targets = optional(list(object({
      path       = string
      exclusions = optional(list(string), [])
    })), [])
    jdbc_targets = optional(list(object({
      connection_name = string
      path            = string
      exclusions      = optional(list(string), [])
    })), [])
    delete_behavior = optional(string, "LOG")
    update_behavior = optional(string, "UPDATE_IN_DATABASE")
    tags            = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# JOB VARIABLES
#==============================================================================
variable "jobs" {
  description = "List of Glue jobs"
  type = list(object({
    name                = string
    description         = optional(string, "Managed by Terraform")
    role_arn            = string
    glue_version        = optional(string, "4.0")
    worker_type         = optional(string, "G.1X")
    number_of_workers   = optional(number, 2)
    timeout             = optional(number, 2880)
    max_retries         = optional(number, 0)
    command_name        = optional(string, "glueetl")
    script_location     = string
    python_version      = optional(string, "3")
    default_arguments   = optional(map(string), {})
    max_concurrent_runs = optional(number)
    tags                = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# TRIGGER VARIABLES
#==============================================================================
variable "triggers" {
  description = "List of Glue triggers"
  type = list(object({
    name     = string
    type     = string
    schedule = optional(string)
    enabled  = optional(bool, true)
    actions = list(object({
      job_name  = string
      arguments = optional(map(string), {})
      timeout   = optional(number)
    }))
    tags = optional(map(string), {})
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
