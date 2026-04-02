#==============================================================================
# DISTRIBUTION SETTINGS
#==============================================================================

variable "enabled" {
  type    = bool
  default = true
}

variable "comment" {
  type    = string
  default = ""
}

variable "default_root_object" {
  type    = string
  default = null
}

variable "price_class" {
  type    = string
  default = "PriceClass_100"
}

variable "aliases" {
  type    = list(string)
  default = []
}

variable "web_acl_id" {
  type    = string
  default = null
}

variable "is_ipv6_enabled" {
  type    = bool
  default = true
}

variable "http_version" {
  type    = string
  default = "http2and3"
}

#==============================================================================
# ORIGINS
#==============================================================================

variable "origins" {
  type = list(object({
    domain_name              = string
    origin_id                = string
    origin_path              = optional(string, "")
    origin_access_control_id = optional(string, null)
    s3_origin_config = optional(object({
      origin_access_identity = string
    }), null)
    custom_origin_config = optional(object({
      http_port                = optional(number, 80)
      https_port               = optional(number, 443)
      origin_protocol_policy   = string
      origin_ssl_protocols     = optional(list(string), ["TLSv1.2"])
      origin_keepalive_timeout = optional(number, 5)
      origin_read_timeout      = optional(number, 30)
    }), null)
    custom_headers = optional(list(object({
      name  = string
      value = string
    })), [])
    origin_shield = optional(object({
      enabled              = bool
      origin_shield_region = string
    }), null)
    connection_attempts = optional(number, 3)
    connection_timeout  = optional(number, 10)
  }))
}

#==============================================================================
# DEFAULT CACHE BEHAVIOR
#==============================================================================

variable "default_cache_behavior" {
  type = object({
    allowed_methods          = optional(list(string), ["GET", "HEAD"])
    cached_methods           = optional(list(string), ["GET", "HEAD"])
    target_origin_id         = string
    viewer_protocol_policy   = optional(string, "redirect-to-https")
    compress                 = optional(bool, true)
    cache_policy_id          = optional(string, null)
    origin_request_policy_id = optional(string, null)
    response_headers_policy_id = optional(string, null)
    forwarded_values = optional(object({
      query_string = optional(bool, false)
      cookies = optional(object({
        forward           = optional(string, "none")
        whitelisted_names = optional(list(string), [])
      }), { forward = "none", whitelisted_names = [] })
      headers = optional(list(string), [])
    }), null)
    min_ttl     = optional(number, 0)
    default_ttl = optional(number, 86400)
    max_ttl     = optional(number, 31536000)
    function_associations = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = optional(bool, false)
    })), [])
  })
}

#==============================================================================
# ORDERED CACHE BEHAVIORS
#==============================================================================

variable "ordered_cache_behaviors" {
  type = list(object({
    path_pattern             = string
    allowed_methods          = optional(list(string), ["GET", "HEAD"])
    cached_methods           = optional(list(string), ["GET", "HEAD"])
    target_origin_id         = string
    viewer_protocol_policy   = optional(string, "redirect-to-https")
    compress                 = optional(bool, true)
    cache_policy_id          = optional(string, null)
    origin_request_policy_id = optional(string, null)
    response_headers_policy_id = optional(string, null)
    forwarded_values = optional(object({
      query_string = optional(bool, false)
      cookies = optional(object({
        forward           = optional(string, "none")
        whitelisted_names = optional(list(string), [])
      }), { forward = "none", whitelisted_names = [] })
      headers = optional(list(string), [])
    }), null)
    min_ttl     = optional(number, 0)
    default_ttl = optional(number, 86400)
    max_ttl     = optional(number, 31536000)
    function_associations = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
    lambda_function_associations = optional(list(object({
      event_type   = string
      lambda_arn   = string
      include_body = optional(bool, false)
    })), [])
  }))
  default = []
}

#==============================================================================
# VIEWER CERTIFICATE
#==============================================================================

variable "viewer_certificate" {
  type = object({
    acm_certificate_arn            = optional(string, null)
    ssl_support_method             = optional(string, "sni-only")
    minimum_protocol_version       = optional(string, "TLSv1.2_2021")
    cloudfront_default_certificate = optional(bool, false)
  })
  default = {
    cloudfront_default_certificate = true
  }
}

#==============================================================================
# RESTRICTIONS
#==============================================================================

variable "restrictions" {
  type = object({
    geo_restriction = object({
      restriction_type = optional(string, "none")
      locations        = optional(list(string), [])
    })
  })
  default = {
    geo_restriction = {
      restriction_type = "none"
      locations        = []
    }
  }
}

#==============================================================================
# LOGGING
#==============================================================================

variable "logging_config" {
  type = object({
    bucket          = string
    prefix          = optional(string, "")
    include_cookies = optional(bool, false)
  })
  default = null
}

#==============================================================================
# CUSTOM ERROR RESPONSES
#==============================================================================

variable "custom_error_responses" {
  type = list(object({
    error_code            = number
    response_code         = optional(number, null)
    response_page_path    = optional(string, null)
    error_caching_min_ttl = optional(number, null)
  }))
  default = []
}

#==============================================================================
# ORIGIN ACCESS CONTROL
#==============================================================================

variable "origin_access_controls" {
  type = list(object({
    name                              = string
    description                       = optional(string, "")
    origin_access_control_origin_type = optional(string, "s3")
    signing_behavior                  = optional(string, "always")
    signing_protocol                  = optional(string, "sigv4")
  }))
  default = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type    = map(string)
  default = {}
}
