#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "description" {
  type    = string
  default = ""
}

variable "api_type" {
  type    = string
  default = "http"

  validation {
    condition     = contains(["rest", "http"], var.api_type)
    error_message = "api_type must be rest or http."
  }
}

variable "protocol_type" {
  type    = string
  default = "HTTP"

  validation {
    condition     = contains(["HTTP", "WEBSOCKET"], var.protocol_type)
    error_message = "protocol_type must be HTTP or WEBSOCKET. For REST APIs, set api_type to rest."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}

#==============================================================================
# STAGE
#==============================================================================

variable "stage_name" {
  type    = string
  default = "$default"
}

variable "stage_auto_deploy" {
  type    = bool
  default = true
}

#==============================================================================
# CORS (V2 ONLY)
#==============================================================================

variable "cors_configuration" {
  type = object({
    allow_origins     = optional(list(string), [])
    allow_methods     = optional(list(string), [])
    allow_headers     = optional(list(string), [])
    expose_headers    = optional(list(string), [])
    max_age           = optional(number, 0)
    allow_credentials = optional(bool, false)
  })
  default = null
}

#==============================================================================
# ROUTES AND INTEGRATIONS (V2 ONLY)
#==============================================================================

variable "routes" {
  type = map(object({
    integration_uri    = string
    integration_type   = optional(string, "AWS_PROXY")
    integration_method = optional(string, "POST")
    authorization_type = optional(string, "NONE")
    authorizer_id      = optional(string, null)
    route_key          = optional(string, null)
  }))
  default = {}
}

#==============================================================================
# CUSTOM DOMAIN
#==============================================================================

variable "domain_name" {
  type    = string
  default = null
}

variable "domain_name_certificate_arn" {
  type    = string
  default = null
}

#==============================================================================
# THROTTLING
#==============================================================================

variable "throttling_burst_limit" {
  type    = number
  default = 5000
}

variable "throttling_rate_limit" {
  type    = number
  default = 10000
}

#==============================================================================
# ACCESS LOGGING
#==============================================================================

variable "access_log_settings" {
  type = object({
    destination_arn = string
    format          = optional(string, null)
  })
  default = null
}

#==============================================================================
# REST API (V1) SPECIFIC
#==============================================================================

variable "endpoint_configuration" {
  type = object({
    types            = list(string)
    vpc_endpoint_ids = optional(list(string), [])
  })
  default = {
    types = ["REGIONAL"]
  }
}

variable "body" {
  type    = string
  default = null
}

variable "xray_tracing_enabled" {
  type    = bool
  default = true
}

variable "cache_enabled" {
  type    = bool
  default = false
}

variable "api_key_source" {
  type    = string
  default = "HEADER"

  validation {
    condition     = contains(["HEADER", "AUTHORIZER"], var.api_key_source)
    error_message = "api_key_source must be HEADER or AUTHORIZER."
  }
}
