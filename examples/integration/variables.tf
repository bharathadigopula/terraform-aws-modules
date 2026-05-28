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
# APPFLOW VARIABLES
#==============================================================================

variable "appflow_name" {
  description = "Value for the name input of the appflow module"
  type        = any
}

variable "appflow_source_connector_type" {
  description = "Value for the source_connector_type input of the appflow module"
  type        = any
}

variable "appflow_destination_connector_type" {
  description = "Value for the destination_connector_type input of the appflow module"
  type        = any
}

#==============================================================================
# MQ VARIABLES
#==============================================================================

variable "mq_broker_name" {
  description = "Value for the broker_name input of the mq module"
  type        = any
}

variable "mq_engine_version" {
  description = "Value for the engine_version input of the mq module"
  type        = any
}

variable "mq_users" {
  description = "Value for the users input of the mq module"
  type        = any
}

#==============================================================================
# MWAA VARIABLES
#==============================================================================

variable "mwaa_name" {
  description = "Value for the name input of the mwaa module"
  type        = any
}

variable "mwaa_execution_role_arn" {
  description = "Value for the execution_role_arn input of the mwaa module"
  type        = any
}

variable "mwaa_source_bucket_arn" {
  description = "Value for the source_bucket_arn input of the mwaa module"
  type        = any
}

variable "mwaa_security_group_ids" {
  description = "Value for the security_group_ids input of the mwaa module"
  type        = any
}

variable "mwaa_subnet_ids" {
  description = "Value for the subnet_ids input of the mwaa module"
  type        = any
}

#==============================================================================
# SNS VARIABLES
#==============================================================================

variable "sns_name" {
  description = "Value for the name input of the sns module"
  type        = any
}

#==============================================================================
# SQS VARIABLES
#==============================================================================

variable "sqs_name" {
  description = "Value for the name input of the sqs module"
  type        = any
}

#==============================================================================
# STEP FUNCTIONS VARIABLES
#==============================================================================

variable "step_functions_name" {
  description = "Value for the name input of the step-functions module"
  type        = any
}

variable "step_functions_role_arn" {
  description = "Value for the role_arn input of the step-functions module"
  type        = any
}

variable "step_functions_definition" {
  description = "Value for the definition input of the step-functions module"
  type        = any
}

#==============================================================================
# SWF VARIABLES
#==============================================================================

variable "swf_name" {
  description = "Value for the name input of the swf module"
  type        = any
}
