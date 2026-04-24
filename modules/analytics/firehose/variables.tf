#==============================================================================
# DELIVERY STREAM VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Firehose delivery stream"
  type        = string
}

variable "destination" {
  description = "Delivery destination (extended_s3, redshift, elasticsearch, http_endpoint, opensearch)"
  type        = string
  default     = "extended_s3"
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================
variable "enable_encryption" {
  description = "Whether to enable server-side encryption"
  type        = bool
  default     = true
}

variable "encryption_key_type" {
  description = "Encryption key type (AWS_OWNED_CMK or CUSTOMER_MANAGED_CMK)"
  type        = string
  default     = "AWS_OWNED_CMK"
}

variable "encryption_key_arn" {
  description = "KMS key ARN when using CUSTOMER_MANAGED_CMK"
  type        = string
  default     = null
}

#==============================================================================
# KINESIS SOURCE VARIABLES
#==============================================================================
variable "kinesis_source_stream_arn" {
  description = "Kinesis stream ARN to use as source"
  type        = string
  default     = null
}

variable "kinesis_source_role_arn" {
  description = "IAM role ARN for reading from Kinesis source"
  type        = string
  default     = null
}

#==============================================================================
# S3 DESTINATION VARIABLES
#==============================================================================
variable "s3_bucket_arn" {
  description = "S3 bucket ARN for extended_s3 destination"
  type        = string
  default     = null
}

variable "s3_role_arn" {
  description = "IAM role ARN for S3 delivery"
  type        = string
  default     = null
}

variable "s3_prefix" {
  description = "S3 prefix for delivered objects"
  type        = string
  default     = null
}

variable "s3_error_output_prefix" {
  description = "S3 prefix for error output"
  type        = string
  default     = null
}

variable "s3_buffering_size" {
  description = "S3 buffering size in MB (1-128)"
  type        = number
  default     = 5
}

variable "s3_buffering_interval" {
  description = "S3 buffering interval in seconds (60-900)"
  type        = number
  default     = 300
}

variable "s3_compression_format" {
  description = "S3 compression format (UNCOMPRESSED, GZIP, ZIP, Snappy, HADOOP_SNAPPY)"
  type        = string
  default     = "GZIP"
}

variable "s3_kms_key_arn" {
  description = "KMS key ARN for S3 encryption"
  type        = string
  default     = null
}

#==============================================================================
# CLOUDWATCH LOGGING VARIABLES
#==============================================================================
variable "enable_cloudwatch_logging" {
  description = "Whether to enable CloudWatch logging"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group name for Firehose logging"
  type        = string
  default     = null
}

variable "cloudwatch_log_stream_name" {
  description = "CloudWatch log stream name for Firehose logging"
  type        = string
  default     = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
