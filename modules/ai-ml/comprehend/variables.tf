#==============================================================================
# COMPREHEND VARIABLES
#==============================================================================

variable "document_classifiers" {
  description = "List of Comprehend document classifiers to create"
  type = list(object({
    name                 = string
    data_access_role_arn = string
    language_code        = string
    mode                 = optional(string)
    version_name         = optional(string)
    version_name_prefix  = optional(string)
    model_kms_key_id     = optional(string)
    volume_kms_key_id    = optional(string)
    input_data_config = object({
      data_format     = optional(string)
      label_delimiter = optional(string)
      s3_uri          = optional(string)
      test_s3_uri     = optional(string)
    })
    output_data_config = optional(object({
      s3_uri     = string
      kms_key_id = optional(string)
    }))
    vpc_config = optional(object({
      security_group_ids = set(string)
      subnets            = set(string)
    }))
    tags = optional(map(string), {})
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
