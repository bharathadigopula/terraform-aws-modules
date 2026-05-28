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
# AURORA VARIABLES
#==============================================================================

variable "aurora_cluster_identifier" {
  description = "Value for the cluster_identifier input of the aurora module"
  type        = any
}

variable "aurora_engine" {
  description = "Value for the engine input of the aurora module"
  type        = any
}

variable "aurora_engine_version" {
  description = "Value for the engine_version input of the aurora module"
  type        = any
}

variable "aurora_instance_class" {
  description = "Value for the instance_class input of the aurora module"
  type        = any
}

variable "aurora_master_username" {
  description = "Value for the master_username input of the aurora module"
  type        = any
}

variable "aurora_master_password" {
  description = "Value for the master_password input of the aurora module"
  type        = any
  sensitive   = true
}

#==============================================================================
# DMS VARIABLES
#==============================================================================

variable "dms_replication_instance_id" {
  description = "Value for the replication_instance_id input of the dms module"
  type        = any
}

variable "dms_replication_instance_class" {
  description = "Value for the replication_instance_class input of the dms module"
  type        = any
}

#==============================================================================
# DOCUMENTDB VARIABLES
#==============================================================================

variable "documentdb_cluster_identifier" {
  description = "Value for the cluster_identifier input of the documentdb module"
  type        = any
}

variable "documentdb_engine_version" {
  description = "Value for the engine_version input of the documentdb module"
  type        = any
}

variable "documentdb_instance_class" {
  description = "Value for the instance_class input of the documentdb module"
  type        = any
}

variable "documentdb_db_subnet_group_name" {
  description = "Value for the db_subnet_group_name input of the documentdb module"
  type        = any
}

variable "documentdb_vpc_security_group_ids" {
  description = "Value for the vpc_security_group_ids input of the documentdb module"
  type        = any
}

variable "documentdb_master_username" {
  description = "Value for the master_username input of the documentdb module"
  type        = any
}

variable "documentdb_master_password" {
  description = "Value for the master_password input of the documentdb module"
  type        = any
  sensitive   = true
}

#==============================================================================
# DYNAMODB VARIABLES
#==============================================================================

variable "dynamodb_name" {
  description = "Value for the name input of the dynamodb module"
  type        = any
}

variable "dynamodb_hash_key" {
  description = "Value for the hash_key input of the dynamodb module"
  type        = any
}

variable "dynamodb_attributes" {
  description = "Value for the attributes input of the dynamodb module"
  type        = any
}

#==============================================================================
# ELASTICACHE VARIABLES
#==============================================================================

variable "elasticache_replication_group_id" {
  description = "Value for the replication_group_id input of the elasticache module"
  type        = any
}

variable "elasticache_description" {
  description = "Value for the description input of the elasticache module"
  type        = any
}

variable "elasticache_engine" {
  description = "Value for the engine input of the elasticache module"
  type        = any
}

variable "elasticache_node_type" {
  description = "Value for the node_type input of the elasticache module"
  type        = any
}

#==============================================================================
# KEYSPACES VARIABLES
#==============================================================================

variable "keyspaces_keyspace_name" {
  description = "Value for the keyspace_name input of the keyspaces module"
  type        = any
}

#==============================================================================
# MEMORYDB VARIABLES
#==============================================================================

variable "memorydb_name" {
  description = "Value for the name input of the memorydb module"
  type        = any
}

variable "memorydb_node_type" {
  description = "Value for the node_type input of the memorydb module"
  type        = any
}

variable "memorydb_acl_name" {
  description = "Value for the acl_name input of the memorydb module"
  type        = any
}

#==============================================================================
# NEPTUNE VARIABLES
#==============================================================================

variable "neptune_cluster_identifier" {
  description = "Value for the cluster_identifier input of the neptune module"
  type        = any
}

variable "neptune_instance_class" {
  description = "Value for the instance_class input of the neptune module"
  type        = any
}

#==============================================================================
# RDS VARIABLES
#==============================================================================

variable "rds_identifier" {
  description = "Value for the identifier input of the rds module"
  type        = any
}

variable "rds_engine" {
  description = "Value for the engine input of the rds module"
  type        = any
}

variable "rds_engine_version" {
  description = "Value for the engine_version input of the rds module"
  type        = any
}

variable "rds_instance_class" {
  description = "Value for the instance_class input of the rds module"
  type        = any
}

variable "rds_allocated_storage" {
  description = "Value for the allocated_storage input of the rds module"
  type        = any
}

variable "rds_username" {
  description = "Value for the username input of the rds module"
  type        = any
}

variable "rds_password" {
  description = "Value for the password input of the rds module"
  type        = any
  sensitive   = true
}

#==============================================================================
# RDS PROXY VARIABLES
#==============================================================================

variable "rds_proxy_name" {
  description = "Value for the name input of the rds-proxy module"
  type        = any
}

variable "rds_proxy_engine_family" {
  description = "Value for the engine_family input of the rds-proxy module"
  type        = any
}

variable "rds_proxy_role_arn" {
  description = "Value for the role_arn input of the rds-proxy module"
  type        = any
}

variable "rds_proxy_vpc_subnet_ids" {
  description = "Value for the vpc_subnet_ids input of the rds-proxy module"
  type        = any
}

variable "rds_proxy_vpc_security_group_ids" {
  description = "Value for the vpc_security_group_ids input of the rds-proxy module"
  type        = any
}

variable "rds_proxy_auth" {
  description = "Value for the auth input of the rds-proxy module"
  type        = any
}

#==============================================================================
# REDSHIFT VARIABLES
#==============================================================================

variable "redshift_cluster_identifier" {
  description = "Value for the cluster_identifier input of the redshift module"
  type        = any
}

variable "redshift_node_type" {
  description = "Value for the node_type input of the redshift module"
  type        = any
}

variable "redshift_database_name" {
  description = "Value for the database_name input of the redshift module"
  type        = any
}

variable "redshift_master_username" {
  description = "Value for the master_username input of the redshift module"
  type        = any
}

variable "redshift_master_password" {
  description = "Value for the master_password input of the redshift module"
  type        = any
  sensitive   = true
}

#==============================================================================
# TIMESTREAM VARIABLES
#==============================================================================

variable "timestream_database_name" {
  description = "Value for the database_name input of the timestream module"
  type        = any
}
