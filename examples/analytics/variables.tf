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
# ATHENA VARIABLES
#==============================================================================

variable "athena_workgroup_name" {
  description = "Value for the workgroup_name input of the athena module"
  type        = any
}

variable "athena_output_location" {
  description = "Value for the output_location input of the athena module"
  type        = any
}

#==============================================================================
# CLEAN ROOMS VARIABLES
#==============================================================================

variable "clean_rooms_name" {
  description = "Value for the name input of the clean-rooms module"
  type        = any
}

variable "clean_rooms_creator_display_name" {
  description = "Value for the creator_display_name input of the clean-rooms module"
  type        = any
}

#==============================================================================
# DATA EXCHANGE VARIABLES
#==============================================================================

variable "data_exchange_name" {
  description = "Value for the name input of the data-exchange module"
  type        = any
}

#==============================================================================
# DATA PIPELINE VARIABLES
#==============================================================================

variable "data_pipeline_name" {
  description = "Value for the name input of the data-pipeline module"
  type        = any
}

#==============================================================================
# DATAZONE VARIABLES
#==============================================================================

variable "datazone_name" {
  description = "Value for the name input of the datazone module"
  type        = any
}

variable "datazone_domain_execution_role" {
  description = "Value for the domain_execution_role input of the datazone module"
  type        = any
}

#==============================================================================
# EMR VARIABLES
#==============================================================================

variable "emr_name" {
  description = "Value for the name input of the emr module"
  type        = any
}

variable "emr_service_role" {
  description = "Value for the service_role input of the emr module"
  type        = any
}

variable "emr_subnet_id" {
  description = "Value for the subnet_id input of the emr module"
  type        = any
}

variable "emr_emr_managed_master_security_group" {
  description = "Value for the emr_managed_master_security_group input of the emr module"
  type        = any
}

variable "emr_emr_managed_slave_security_group" {
  description = "Value for the emr_managed_slave_security_group input of the emr module"
  type        = any
}

variable "emr_instance_profile" {
  description = "Value for the instance_profile input of the emr module"
  type        = any
}

#==============================================================================
# FIREHOSE VARIABLES
#==============================================================================

variable "firehose_name" {
  description = "Value for the name input of the firehose module"
  type        = any
}

#==============================================================================
# FLINK VARIABLES
#==============================================================================

variable "flink_name" {
  description = "Value for the name input of the flink module"
  type        = any
}

variable "flink_service_execution_role" {
  description = "Value for the service_execution_role input of the flink module"
  type        = any
}

#==============================================================================
# KINESIS VARIABLES
#==============================================================================

variable "kinesis_name" {
  description = "Value for the name input of the kinesis module"
  type        = any
}

#==============================================================================
# MSK VARIABLES
#==============================================================================

variable "msk_cluster_name" {
  description = "Value for the cluster_name input of the msk module"
  type        = any
}

variable "msk_client_subnets" {
  description = "Value for the client_subnets input of the msk module"
  type        = any
}

variable "msk_security_groups" {
  description = "Value for the security_groups input of the msk module"
  type        = any
}

#==============================================================================
# OPENSEARCH VARIABLES
#==============================================================================

variable "opensearch_domain_name" {
  description = "Value for the domain_name input of the opensearch module"
  type        = any
}
