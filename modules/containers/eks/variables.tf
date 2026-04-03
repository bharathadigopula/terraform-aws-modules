#==============================================================================
# EKS CLUSTER VARIABLES
#==============================================================================
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role that provides permissions for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster ENIs"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Whether the EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the EKS public API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enabled_cluster_log_types" {
  description = "List of EKS control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "encryption_config" {
  description = "Configuration for EKS cluster encryption using a KMS key"
  type = object({
    provider_key_arn = string
    resources        = optional(list(string), ["secrets"])
  })
  default = null
}

variable "kubernetes_network_config" {
  description = "Kubernetes network configuration for the cluster"
  type = object({
    service_ipv4_cidr = optional(string)
    ip_family         = optional(string, "ipv4")
  })
  default = null
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EKS cluster"
  type        = list(string)
  default     = []
}

variable "cluster_addons" {
  description = "Map of EKS cluster addon configurations keyed by addon name"
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
  }))
  default = {}
}

variable "access_config" {
  description = "Access configuration for the EKS cluster API server"
  type = object({
    authentication_mode = optional(string, "API_AND_CONFIG_MAP")
  })
  default = null
}

variable "log_retention_days" {
  description = "Number of days to retain EKS cluster CloudWatch logs"
  type        = number
  default     = 365
}

variable "log_kms_key_id" {
  description = "KMS key ARN for encrypting the EKS CloudWatch log group"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to all resources in this module"
  type        = map(string)
  default     = {}
}
