#==============================================================================
# LIGHTSAIL INSTANCE VARIABLES
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Lightsail instance"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the Lightsail instance"
}

variable "blueprint_id" {
  type        = string
  description = "Blueprint ID for the Lightsail instance (e.g. amazon_linux_2, ubuntu_20_04)"
}

variable "bundle_id" {
  type        = string
  description = "Bundle ID for the Lightsail instance (e.g. nano_3_0, micro_3_0)"
}

variable "key_pair_name" {
  type        = string
  description = "Name of the key pair to use for SSH access"
  default     = null
}

variable "user_data" {
  type        = string
  description = "User data script to run on instance launch"
  default     = null
}

variable "ip_address_type" {
  type        = string
  description = "IP address type for the instance (dualstack or ipv4)"
  default     = "dualstack"
}

variable "create_static_ip" {
  type        = bool
  description = "Whether to create and attach a static IP to the instance"
  default     = false
}

variable "create_public_ports" {
  type        = bool
  description = "Whether to create public port rules for the instance"
  default     = false
}

variable "public_ports" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  description = "List of public port rules to open on the instance"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
