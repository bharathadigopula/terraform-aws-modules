#==============================================================================
# WAF WEB ACL VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the WAF Web ACL"
  type        = string
}

variable "description" {
  description = "Description of the WAF Web ACL"
  type        = string
  default     = "Managed by Terraform"
}

variable "scope" {
  description = "Scope of the WAF (REGIONAL or CLOUDFRONT)"
  type        = string
  default     = "REGIONAL"
}

variable "default_action" {
  description = "Default action for the Web ACL (allow or block)"
  type        = string
  default     = "allow"
}

variable "cloudwatch_metrics_enabled" {
  description = "Whether CloudWatch metrics are enabled"
  type        = bool
  default     = true
}

variable "sampled_requests_enabled" {
  description = "Whether sampled requests are enabled"
  type        = bool
  default     = true
}

#==============================================================================
# MANAGED RULE VARIABLES
#==============================================================================
variable "managed_rules" {
  description = "List of AWS managed rule groups"
  type = list(object({
    name                    = string
    priority                = number
    managed_rule_group_name = string
    vendor_name             = optional(string, "AWS")
    override_action         = optional(string, "none")
    excluded_rules          = optional(list(string), [])
  }))
  default = []
}

#==============================================================================
# RATE LIMIT RULE VARIABLES
#==============================================================================
variable "rate_limit_rules" {
  description = "List of rate-based rules"
  type = list(object({
    name               = string
    priority           = number
    limit              = number
    aggregate_key_type = optional(string, "IP")
  }))
  default = []
}

#==============================================================================
# IP SET RULE VARIABLES
#==============================================================================
variable "ip_set_rules" {
  description = "List of IP set reference rules"
  type = list(object({
    name       = string
    priority   = number
    action     = string
    ip_set_arn = string
  }))
  default = []
}

#==============================================================================
# ASSOCIATION VARIABLES
#==============================================================================
variable "resource_arns" {
  description = "List of resource ARNs to associate with the Web ACL"
  type        = list(string)
  default     = []
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "logging_destination_arn" {
  description = "ARN of the logging destination (Kinesis Firehose, S3, or CloudWatch Logs)"
  type        = string
  default     = null
}

variable "redacted_fields" {
  description = "List of fields to redact from logs"
  type = list(object({
    single_header = optional(string)
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
