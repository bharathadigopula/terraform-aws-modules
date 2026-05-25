#==============================================================================
# LEX VARIABLES
#==============================================================================

variable "bots" {
  description = "List of Lex V2 bots to create"
  type = list(object({
    name                        = string
    role_arn                    = string
    idle_session_ttl_in_seconds = number
    child_directed              = bool
    description                 = optional(string)
    type                        = optional(string)
    members = optional(list(object({
      id         = string
      name       = string
      alias_id   = string
      alias_name = string
      version    = string
    })), [])
    tags                = optional(map(string), {})
    test_bot_alias_tags = optional(map(string), {})
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
