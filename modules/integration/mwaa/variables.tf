#==============================================================================
# ENVIRONMENT VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the MWAA environment"
  type        = string
}

variable "airflow_version" {
  description = "Apache Airflow version"
  type        = string
  default     = null
}

variable "environment_class" {
  description = "Environment class (mw1.small, mw1.medium, mw1.large)"
  type        = string
  default     = "mw1.small"
}

variable "execution_role_arn" {
  description = "IAM execution role ARN"
  type        = string
}

variable "max_workers" {
  description = "Maximum number of workers"
  type        = number
  default     = 10
}

variable "min_workers" {
  description = "Minimum number of workers"
  type        = number
  default     = 1
}

variable "schedulers" {
  description = "Number of schedulers"
  type        = number
  default     = 2
}

variable "webserver_access_mode" {
  description = "Webserver access mode (PRIVATE_ONLY or PUBLIC_ONLY)"
  type        = string
  default     = "PRIVATE_ONLY"
}

variable "weekly_maintenance_window_start" {
  description = "Weekly maintenance window start (e.g., SUN:03:00)"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "KMS key ARN for encryption"
  type        = string
  default     = null
}

variable "airflow_configuration_options" {
  description = "Map of Airflow configuration options"
  type        = map(string)
  default     = {}
}

#==============================================================================
# S3 SOURCE VARIABLES
#==============================================================================
variable "source_bucket_arn" {
  description = "S3 bucket ARN for DAGs and plugins"
  type        = string
}

variable "dag_s3_path" {
  description = "S3 key prefix for DAG files"
  type        = string
  default     = "dags/"
}

variable "plugins_s3_path" {
  description = "S3 key for plugins.zip"
  type        = string
  default     = null
}

variable "plugins_s3_object_version" {
  description = "S3 object version for plugins.zip"
  type        = string
  default     = null
}

variable "requirements_s3_path" {
  description = "S3 key for requirements.txt"
  type        = string
  default     = null
}

variable "requirements_s3_object_version" {
  description = "S3 object version for requirements.txt"
  type        = string
  default     = null
}

variable "startup_script_s3_path" {
  description = "S3 key for startup script"
  type        = string
  default     = null
}

variable "startup_script_s3_object_version" {
  description = "S3 object version for startup script"
  type        = string
  default     = null
}

#==============================================================================
# NETWORK VARIABLES
#==============================================================================
variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs (minimum 2)"
  type        = list(string)
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "dag_processing_logs_enabled" {
  description = "Enable DAG processing logs"
  type        = bool
  default     = true
}

variable "dag_processing_logs_level" {
  description = "DAG processing log level"
  type        = string
  default     = "WARNING"
}

variable "scheduler_logs_enabled" {
  description = "Enable scheduler logs"
  type        = bool
  default     = true
}

variable "scheduler_logs_level" {
  description = "Scheduler log level"
  type        = string
  default     = "WARNING"
}

variable "task_logs_enabled" {
  description = "Enable task logs"
  type        = bool
  default     = true
}

variable "task_logs_level" {
  description = "Task log level"
  type        = string
  default     = "INFO"
}

variable "webserver_logs_enabled" {
  description = "Enable webserver logs"
  type        = bool
  default     = true
}

variable "webserver_logs_level" {
  description = "Webserver log level"
  type        = string
  default     = "WARNING"
}

variable "worker_logs_enabled" {
  description = "Enable worker logs"
  type        = bool
  default     = true
}

variable "worker_logs_level" {
  description = "Worker log level"
  type        = string
  default     = "WARNING"
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
