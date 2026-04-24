#==============================================================================
# CLUSTER VARIABLES
#==============================================================================
variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "kafka_version" {
  description = "Kafka version"
  type        = string
  default     = "3.7.x"
}

variable "number_of_broker_nodes" {
  description = "Number of broker nodes (must be multiple of subnets)"
  type        = number
  default     = 3
}

variable "broker_instance_type" {
  description = "Broker instance type"
  type        = string
  default     = "kafka.t3.small"
}

variable "client_subnets" {
  description = "List of subnet IDs for brokers"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "broker_volume_size" {
  description = "EBS volume size per broker (GB)"
  type        = number
  default     = 100
}

variable "public_access_type" {
  description = "Public access type (DISABLED, SERVICE_PROVIDED_EIPS)"
  type        = string
  default     = "DISABLED"
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================
variable "kms_key_arn" {
  description = "KMS key ARN for encryption at rest"
  type        = string
  default     = null
}

variable "encryption_in_transit_client_broker" {
  description = "Client-broker encryption (TLS, TLS_PLAINTEXT, PLAINTEXT)"
  type        = string
  default     = "TLS"
}

variable "encryption_in_transit_in_cluster" {
  description = "Whether to enable encryption within the cluster"
  type        = bool
  default     = true
}

#==============================================================================
# AUTHENTICATION VARIABLES
#==============================================================================
variable "enable_sasl_iam" {
  description = "Enable IAM authentication"
  type        = bool
  default     = true
}

variable "enable_sasl_scram" {
  description = "Enable SCRAM authentication"
  type        = bool
  default     = false
}

variable "enable_tls" {
  description = "Enable TLS authentication"
  type        = bool
  default     = false
}

variable "tls_certificate_authority_arns" {
  description = "List of ACM Private CA ARNs for TLS"
  type        = list(string)
  default     = []
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "enable_cloudwatch_logs" {
  description = "Enable CloudWatch logs"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group" {
  description = "CloudWatch log group name"
  type        = string
  default     = null
}

variable "enable_firehose_logs" {
  description = "Enable Firehose logs"
  type        = bool
  default     = false
}

variable "firehose_delivery_stream" {
  description = "Firehose delivery stream name"
  type        = string
  default     = null
}

variable "enable_s3_logs" {
  description = "Enable S3 logs"
  type        = bool
  default     = false
}

variable "s3_log_bucket" {
  description = "S3 bucket name for logs"
  type        = string
  default     = null
}

variable "s3_log_prefix" {
  description = "S3 log prefix"
  type        = string
  default     = null
}

#==============================================================================
# CONFIGURATION VARIABLES
#==============================================================================
variable "server_properties" {
  description = "MSK server.properties configuration"
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
