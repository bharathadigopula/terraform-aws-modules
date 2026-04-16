#==============================================================================
# STATE MACHINE VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the state machine"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for the state machine"
  type        = string
}

variable "definition" {
  description = "Amazon States Language definition JSON"
  type        = string
}

variable "type" {
  description = "State machine type (STANDARD or EXPRESS)"
  type        = string
  default     = "STANDARD"
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "log_destination" {
  description = "CloudWatch Log Group ARN for execution logging"
  type        = string
  default     = null
}

variable "include_execution_data" {
  description = "Whether to include execution data in logs"
  type        = bool
  default     = false
}

variable "log_level" {
  description = "Log level (ALL, ERROR, FATAL, OFF)"
  type        = string
  default     = "OFF"
}

#==============================================================================
# TRACING VARIABLES
#==============================================================================
variable "tracing_enabled" {
  description = "Whether X-Ray tracing is enabled"
  type        = bool
  default     = true
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
