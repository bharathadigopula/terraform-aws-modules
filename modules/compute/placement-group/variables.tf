#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the placement group"
}

variable "strategy" {
  type        = string
  description = "Placement strategy"

  validation {
    condition     = contains(["cluster", "spread", "partition"], var.strategy)
    error_message = "Strategy must be cluster, spread, or partition."
  }
}

#==============================================================================
# STRATEGY-SPECIFIC
#==============================================================================

variable "partition_count" {
  type        = number
  description = "Number of partitions when using the partition strategy"
  default     = null
}

variable "spread_level" {
  type        = string
  description = "Spread level when using the spread strategy"
  default     = null

  validation {
    condition     = var.spread_level == null || contains(["host", "rack"], var.spread_level)
    error_message = "Spread level must be host or rack."
  }
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the placement group"
  default     = {}
}
