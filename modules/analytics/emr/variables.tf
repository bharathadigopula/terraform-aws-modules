#==============================================================================
# CLUSTER VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the EMR cluster"
  type        = string
}

variable "release_label" {
  description = "EMR release label (e.g., emr-6.15.0)"
  type        = string
  default     = "emr-7.2.0"
}

variable "applications" {
  description = "List of applications to install"
  type        = list(string)
  default     = ["Spark", "Hadoop"]
}

variable "log_uri" {
  description = "S3 URI for cluster logs"
  type        = string
  default     = null
}

variable "service_role" {
  description = "IAM role for EMR service"
  type        = string
}

variable "autoscaling_role" {
  description = "IAM role for auto-scaling"
  type        = string
  default     = null
}

variable "scale_down_behavior" {
  description = "Scale-down behavior (TERMINATE_AT_TASK_COMPLETION or TERMINATE_AT_INSTANCE_HOUR)"
  type        = string
  default     = "TERMINATE_AT_TASK_COMPLETION"
}

variable "visible_to_all_users" {
  description = "Whether cluster is visible to all IAM users"
  type        = bool
  default     = true
}

variable "termination_protection" {
  description = "Whether termination protection is enabled"
  type        = bool
  default     = true
}

variable "keep_job_flow_alive_when_no_steps" {
  description = "Keep the cluster alive when no steps are running"
  type        = bool
  default     = true
}

#==============================================================================
# EC2 ATTRIBUTES
#==============================================================================
variable "subnet_id" {
  description = "Subnet ID for the cluster"
  type        = string
}

variable "emr_managed_master_security_group" {
  description = "Security group for master node"
  type        = string
}

variable "emr_managed_slave_security_group" {
  description = "Security group for slave nodes"
  type        = string
}

variable "instance_profile" {
  description = "EC2 instance profile for cluster nodes"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = null
}

#==============================================================================
# MASTER INSTANCE GROUP
#==============================================================================
variable "master_instance_type" {
  description = "Instance type for master nodes"
  type        = string
  default     = "m5.xlarge"
}

variable "master_instance_count" {
  description = "Number of master instances"
  type        = number
  default     = 1
}

variable "master_ebs_size" {
  description = "EBS volume size for master (GB)"
  type        = number
  default     = 100
}

variable "master_ebs_type" {
  description = "EBS volume type for master"
  type        = string
  default     = "gp3"
}

variable "master_ebs_volumes_per_instance" {
  description = "EBS volumes per master instance"
  type        = number
  default     = 1
}

#==============================================================================
# CORE INSTANCE GROUP
#==============================================================================
variable "core_instance_type" {
  description = "Instance type for core nodes"
  type        = string
  default     = "m5.xlarge"
}

variable "core_instance_count" {
  description = "Number of core instances"
  type        = number
  default     = 2
}

variable "core_bid_price" {
  description = "Bid price for core spot instances"
  type        = string
  default     = null
}

variable "core_ebs_size" {
  description = "EBS volume size for core (GB)"
  type        = number
  default     = 100
}

variable "core_ebs_type" {
  description = "EBS volume type for core"
  type        = string
  default     = "gp3"
}

variable "core_ebs_volumes_per_instance" {
  description = "EBS volumes per core instance"
  type        = number
  default     = 1
}

#==============================================================================
# KERBEROS VARIABLES
#==============================================================================
variable "kerberos_realm" {
  description = "Kerberos realm"
  type        = string
  default     = null
}

variable "kdc_admin_password" {
  description = "Kerberos KDC admin password"
  type        = string
  default     = null
  sensitive   = true
}

#==============================================================================
# SECURITY CONFIGURATION
#==============================================================================
variable "security_configuration" {
  description = "Name of existing security configuration"
  type        = string
  default     = null
}

variable "security_config_json" {
  description = "JSON security configuration to create"
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
