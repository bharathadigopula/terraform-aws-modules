#==============================================================================
# RDS Proxy Variables
#==============================================================================
variable "name" {
  description = "Name of the RDS Proxy"
  type        = string
}

variable "engine_family" {
  description = "The kind of database engine that the proxy will connect to (MYSQL or POSTGRESQL)"
  type        = string

  validation {
    condition     = contains(["MYSQL", "POSTGRESQL"], var.engine_family)
    error_message = "engine_family must be either MYSQL or POSTGRESQL."
  }
}

variable "role_arn" {
  description = "ARN of the IAM role that the proxy uses to access secrets in AWS Secrets Manager"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of VPC subnet IDs for the proxy"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the proxy"
  type        = list(string)
}

variable "auth" {
  description = "List of authentication configurations for the proxy"
  type = list(object({
    auth_scheme = optional(string, "SECRETS")
    description = optional(string, "")
    iam_auth    = optional(string, "DISABLED")
    secret_arn  = string
  }))
}

variable "debug_logging" {
  description = "Whether the proxy includes detailed information about SQL statements in its logs"
  type        = bool
  default     = false
}

variable "idle_client_timeout" {
  description = "Number of seconds that a connection to the proxy can be inactive before the proxy disconnects it"
  type        = number
  default     = 1800
}

variable "require_tls" {
  description = "Whether Transport Layer Security (TLS) encryption is required for connections to the proxy"
  type        = bool
  default     = true
}

variable "target_db_instance_identifier" {
  description = "DB instance identifier to associate with the proxy target"
  type        = string
  default     = null
}

variable "target_db_cluster_identifier" {
  description = "DB cluster identifier to associate with the proxy target"
  type        = string
  default     = null
}

variable "connection_pool_config" {
  description = "Connection pool configuration for the proxy default target group"
  type = object({
    connection_borrow_timeout    = optional(number, 120)
    max_connections_percent      = optional(number, 100)
    max_idle_connections_percent = optional(number, 50)
  })
  default = {}
}

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
