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
# BACKUP VARIABLES
#==============================================================================

variable "backup_vault_name" {
  description = "Value for the vault_name input of the backup module"
  type        = any
}

variable "backup_kms_key_arn" {
  description = "Value for the kms_key_arn input of the backup module"
  type        = any
}

variable "backup_plan_name" {
  description = "Value for the plan_name input of the backup module"
  type        = any
}

variable "backup_plan_rules" {
  description = "Value for the plan_rules input of the backup module"
  type        = any
}

variable "backup_selection_name" {
  description = "Value for the selection_name input of the backup module"
  type        = any
}

variable "backup_selection_iam_role_arn" {
  description = "Value for the selection_iam_role_arn input of the backup module"
  type        = any
}

#==============================================================================
# EBS VARIABLES
#==============================================================================

variable "ebs_availability_zone" {
  description = "Value for the availability_zone input of the ebs module"
  type        = any
}

variable "ebs_size" {
  description = "Value for the size input of the ebs module"
  type        = any
}

#==============================================================================
# EFS VARIABLES
#==============================================================================

variable "efs_name" {
  description = "Value for the name input of the efs module"
  type        = any
}

variable "efs_subnet_ids" {
  description = "Value for the subnet_ids input of the efs module"
  type        = any
}

variable "efs_security_group_ids" {
  description = "Value for the security_group_ids input of the efs module"
  type        = any
}

#==============================================================================
# FSX LUSTRE VARIABLES
#==============================================================================

variable "fsx_lustre_storage_capacity" {
  description = "Value for the storage_capacity input of the fsx-lustre module"
  type        = any
}

variable "fsx_lustre_subnet_ids" {
  description = "Value for the subnet_ids input of the fsx-lustre module"
  type        = any
}

#==============================================================================
# FSX ONTAP VARIABLES
#==============================================================================

variable "fsx_ontap_storage_capacity" {
  description = "Value for the storage_capacity input of the fsx-ontap module"
  type        = any
}

variable "fsx_ontap_subnet_ids" {
  description = "Value for the subnet_ids input of the fsx-ontap module"
  type        = any
}

variable "fsx_ontap_throughput_capacity" {
  description = "Value for the throughput_capacity input of the fsx-ontap module"
  type        = any
}

variable "fsx_ontap_preferred_subnet_id" {
  description = "Value for the preferred_subnet_id input of the fsx-ontap module"
  type        = any
}

#==============================================================================
# FSX OPENZFS VARIABLES
#==============================================================================

variable "fsx_openzfs_storage_capacity" {
  description = "Value for the storage_capacity input of the fsx-openzfs module"
  type        = any
}

variable "fsx_openzfs_subnet_ids" {
  description = "Value for the subnet_ids input of the fsx-openzfs module"
  type        = any
}

variable "fsx_openzfs_throughput_capacity" {
  description = "Value for the throughput_capacity input of the fsx-openzfs module"
  type        = any
}

#==============================================================================
# FSX WINDOWS VARIABLES
#==============================================================================

variable "fsx_windows_storage_capacity" {
  description = "Value for the storage_capacity input of the fsx-windows module"
  type        = any
}

variable "fsx_windows_subnet_ids" {
  description = "Value for the subnet_ids input of the fsx-windows module"
  type        = any
}

variable "fsx_windows_throughput_capacity" {
  description = "Value for the throughput_capacity input of the fsx-windows module"
  type        = any
}

#==============================================================================
# S3 VARIABLES
#==============================================================================

variable "s3_bucket_name" {
  description = "Value for the bucket_name input of the s3 module"
  type        = any
}

#==============================================================================
# S3 REPLICATION VARIABLES
#==============================================================================

variable "s3_replication_source_bucket_id" {
  description = "Value for the source_bucket_id input of the s3-replication module"
  type        = any
}

variable "s3_replication_role_arn" {
  description = "Value for the role_arn input of the s3-replication module"
  type        = any
}

variable "s3_replication_rules" {
  description = "Value for the rules input of the s3-replication module"
  type        = any
}

#==============================================================================
# STORAGE GATEWAY VARIABLES
#==============================================================================

variable "storage_gateway_gateway_name" {
  description = "Value for the gateway_name input of the storage-gateway module"
  type        = any
}
