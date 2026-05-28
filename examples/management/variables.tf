#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# CLOUDTRAIL VARIABLES
#==============================================================================

variable "cloudtrail_name" {
  description = "Value for the name input of the cloudtrail module"
  type        = any
}

variable "cloudtrail_s3_bucket_name" {
  description = "Value for the s3_bucket_name input of the cloudtrail module"
  type        = any
}

#==============================================================================
# MANAGED GRAFANA VARIABLES
#==============================================================================

variable "managed_grafana_name" {
  description = "Value for the name input of the managed-grafana module"
  type        = any
}
