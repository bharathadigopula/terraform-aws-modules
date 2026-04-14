#==============================================================================
# ACM CERTIFICATE VARIABLES
#==============================================================================
variable "domain_name" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of subject alternative names"
  type        = list(string)
  default     = []
}

variable "validation_method" {
  description = "Validation method (DNS or EMAIL)"
  type        = string
  default     = "DNS"
}

variable "key_algorithm" {
  description = "Algorithm for the certificate key (RSA_2048, EC_prime256v1, EC_secp384r1)"
  type        = string
  default     = "RSA_2048"
}

variable "wait_for_validation" {
  description = "Whether to wait for certificate validation to complete"
  type        = bool
  default     = false
}

variable "validation_record_fqdns" {
  description = "List of FQDNs that implement the validation"
  type        = list(string)
  default     = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
