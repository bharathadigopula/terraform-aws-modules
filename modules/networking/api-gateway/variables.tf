#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = ""
}

variable "api_type" {
  description = "Type of API Gateway to create (rest or http)"
  type        = string
  default     = "http"

  validation {
    condition     = contains(["rest", "http"], var.api_type)
    error_message = "api_type must be rest or http."
  }
}

variable "protocol_type" {
  description = "Protocol type for the API (HTTP or WEBSOCKET)"
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "WEBSOCKET"], var.protocol_type)
    error_message = "protocol_type must be HTTP or WEBSOCKET. For REST APIs, set api_type to rest."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# STAGE
#==============================================================================

variable "stage_name" {
  description = "Name of the API Gateway stage"
  type        = string
  default     = "$default"
}

variable "stage_auto_deploy" {
  description = "Whether updates to the API are automatically deployed to the stage"
  type        = bool
  default     = true
}

#==============================================================================
# CORS (V2 ONLY)
#==============================================================================

variable "cors_configuration" {
  description = "CORS configuration for the V2 API"
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
  description = "Map of route keys to integration configurations for V2 APIs"
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
  description = "Custom domain name for the API Gateway"
  type        = string
  default     = null
}

variable "domain_name_certificate_arn" {
  description = "ARN of the ACM certificate for the custom domain"
  type        = string
  default     = null
}

#==============================================================================
# THROTTLING
#==============================================================================

variable "throttling_burst_limit" {
  description = "Maximum number of concurrent requests for throttling"
  type        = number
  default     = 5000
}

variable "throttling_rate_limit" {
  description = "Maximum steady-state requests per second for throttling"
  type        = number
  default     = 10000
}

#==============================================================================
# ACCESS LOGGING
#==============================================================================

variable "access_log_settings" {
  description = "Access log destination and format configuration"
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
  description = "Endpoint type and VPC endpoint configuration for REST APIs"
  type = object({
    types            = list(string)
    vpc_endpoint_ids = optional(list(string), [])
  })
  default = {
    types = ["REGIONAL"]
  }
}

variable "body" {
  description = "OpenAPI specification body for the REST API"
  type        = string
  default     = null
}

variable "xray_tracing_enabled" {
  description = "Whether X-Ray tracing is enabled for the REST API"
  type        = bool
  default     = true
}

variable "cache_enabled" {
  description = "Whether caching is enabled for the REST API stage"
  type        = bool
  default     = false
}

variable "api_key_source" {
  description = "Source of the API key for requests (HEADER or AUTHORIZER)"
  type        = string
  default     = "HEADER"

  validation {
    condition     = contains(["HEADER", "AUTHORIZER"], var.api_key_source)
    error_message = "api_key_source must be HEADER or AUTHORIZER."
  }
}
