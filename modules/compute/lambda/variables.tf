#==============================================================================
# LAMBDA FUNCTION CONFIGURATION
#==============================================================================

variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the Lambda function"
}

variable "handler" {
  type        = string
  default     = null
  description = "Function entrypoint in the code"
}

variable "runtime" {
  type        = string
  default     = null
  description = "Runtime environment for the Lambda function"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Amount of time the function has to run in seconds"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB allocated to the function"
}

#==============================================================================
# DEPLOYMENT PACKAGE
#==============================================================================

variable "filename" {
  type        = string
  default     = null
  description = "Path to the function deployment package within the local filesystem"
}

variable "s3_bucket" {
  type        = string
  default     = null
  description = "S3 bucket containing the function deployment package"
}

variable "s3_key" {
  type        = string
  default     = null
  description = "S3 key of the function deployment package"
}

variable "s3_object_version" {
  type        = string
  default     = null
  description = "Object version of the function deployment package on S3"
}

variable "source_code_hash" {
  type        = string
  default     = null
  description = "Base64-encoded SHA256 hash of the deployment package"
}

variable "layers" {
  type        = list(string)
  default     = []
  description = "List of Lambda layer ARNs to attach to the function"
}

variable "publish" {
  type        = bool
  default     = false
  description = "Whether to publish creation or change as a new Lambda function version"
}

#==============================================================================
# ARCHITECTURE AND PACKAGE TYPE
#==============================================================================

variable "architectures" {
  type        = list(string)
  default     = ["x86_64"]
  description = "Instruction set architecture for the function"
}

variable "package_type" {
  type        = string
  default     = "Zip"
  description = "Lambda deployment package type: Zip or Image"

  validation {
    condition     = contains(["Zip", "Image"], var.package_type)
    error_message = "package_type must be either Zip or Image"
  }
}

variable "image_uri" {
  type        = string
  default     = null
  description = "ECR image URI for container-based Lambda functions"
}

variable "image_config" {
  type = object({
    command           = optional(list(string), null)
    entry_point       = optional(list(string), null)
    working_directory = optional(string, null)
  })
  default     = null
  description = "Container image configuration overrides"
}

#==============================================================================
# RUNTIME CONFIGURATION
#==============================================================================

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Map of environment variables for the Lambda function"
}

variable "reserved_concurrent_executions" {
  type        = number
  default     = -1
  description = "Amount of reserved concurrent executions for the function"
}

#==============================================================================
# IAM ROLE CONFIGURATION
#==============================================================================

variable "role_arn" {
  type        = string
  default     = null
  description = "ARN of the IAM role for the Lambda function"
}

variable "create_role" {
  type        = bool
  default     = true
  description = "Whether to create an IAM role for the Lambda function"
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM policy ARNs to attach to the created role"
}

#==============================================================================
# NETWORKING
#==============================================================================

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default     = null
  description = "VPC configuration for the Lambda function"
}

#==============================================================================
# ERROR HANDLING AND OBSERVABILITY
#==============================================================================

variable "dead_letter_config" {
  type = object({
    target_arn = string
  })
  default     = null
  description = "Dead letter queue configuration for failed async invocations"
}

variable "tracing_config_mode" {
  type        = string
  default     = null
  description = "X-Ray tracing mode: PassThrough or Active"
}

variable "log_retention_days" {
  type        = number
  default     = 14
  description = "Number of days to retain CloudWatch log events"
}

#==============================================================================
# STORAGE AND ENCRYPTION
#==============================================================================

variable "ephemeral_storage_size" {
  type        = number
  default     = null
  description = "Size of the /tmp directory in MB (512 to 10240)"
}

variable "kms_key_arn" {
  type        = string
  default     = null
  description = "ARN of the KMS key used to encrypt environment variables"
}

variable "code_signing_config_arn" {
  type        = string
  default     = null
  description = "ARN of the code signing configuration"
}

#==============================================================================
# TRIGGERS AND EVENT SOURCE MAPPINGS
#==============================================================================

variable "allowed_triggers" {
  type = map(object({
    principal      = string
    source_arn     = optional(string, null)
    source_account = optional(string, null)
  }))
  default     = {}
  description = "Map of allowed triggers to create Lambda permissions"
}

variable "event_source_mappings" {
  type = list(object({
    event_source_arn  = string
    batch_size        = optional(number, null)
    starting_position = optional(string, null)
    enabled           = optional(bool, true)
    filter_criteria   = optional(list(string), null)
  }))
  default     = []
  description = "List of event source mapping configurations"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to apply to all resources"
}
