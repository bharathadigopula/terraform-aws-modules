#==============================================================================
# NETWORK FIREWALL VARIABLES
#==============================================================================

variable "name" {
  description = "Name for the Network Firewall and related resources"
  type        = string
}

variable "description" {
  description = "Description of the firewall"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID where the firewall will be deployed"
  type        = string
}

variable "subnet_mapping" {
  description = "List of subnet IDs for firewall endpoints (one per AZ)"
  type = list(object({
    subnet_id = string
  }))
}

variable "delete_protection" {
  description = "Protect the firewall from deletion"
  type        = bool
  default     = true
}

variable "firewall_policy_change_protection" {
  description = "Protect the firewall from policy changes"
  type        = bool
  default     = false
}

variable "subnet_change_protection" {
  description = "Protect the firewall from subnet changes"
  type        = bool
  default     = false
}

#==============================================================================
# FIREWALL POLICY VARIABLES
#==============================================================================

variable "policy_name" {
  description = "Name for the firewall policy"
  type        = string
  default     = ""
}

variable "policy_description" {
  description = "Description of the firewall policy"
  type        = string
  default     = ""
}

variable "stateless_default_actions" {
  description = "Default actions for stateless traffic (aws:pass, aws:drop, aws:forward_to_sfe)"
  type        = list(string)
  default     = ["aws:forward_to_sfe"]
}

variable "stateless_fragment_default_actions" {
  description = "Default actions for fragmented stateless traffic"
  type        = list(string)
  default     = ["aws:forward_to_sfe"]
}

variable "stateful_rule_group_references" {
  description = "List of stateful rule group ARNs to attach to the policy"
  type = list(object({
    priority     = number
    resource_arn = string
  }))
  default = []
}

variable "stateless_rule_group_references" {
  description = "List of stateless rule group ARNs to attach to the policy"
  type = list(object({
    priority     = number
    resource_arn = string
  }))
  default = []
}

#==============================================================================
# RULE GROUP VARIABLES
#==============================================================================

variable "stateful_rule_groups" {
  description = "Stateful rule groups to create (Suricata-compatible rules)"
  type = list(object({
    name         = string
    capacity     = number
    rules_string = string
  }))
  default = []
}

variable "stateless_rule_groups" {
  description = "Stateless rule groups to create"
  type = list(object({
    name     = string
    capacity = number
    priority = number
    rules = list(object({
      priority = number
      actions  = list(string)
      match_attributes = object({
        protocols         = list(number)
        source_cidrs      = list(string)
        destination_cidrs = list(string)
        source_ports      = list(object({ from_port = number, to_port = number }))
        destination_ports = list(object({ from_port = number, to_port = number }))
      })
    }))
  }))
  default = []
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================

variable "logging_configuration" {
  description = "Logging configuration for the firewall"
  type = list(object({
    log_destination_type = string
    log_type             = string
    log_destination      = map(string)
  }))
  default = []
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================

variable "kms_key_arn" {
  description = "KMS key ARN for encrypting the firewall, policy, and rule groups"
  type        = string
  default     = null
}

#==============================================================================
# TAGGING VARIABLES
#==============================================================================

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
