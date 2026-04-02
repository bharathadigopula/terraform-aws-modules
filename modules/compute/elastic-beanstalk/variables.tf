#==============================================================================
# ELASTIC BEANSTALK APPLICATION VARIABLES
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Elastic Beanstalk application and environment"
}

variable "description" {
  type        = string
  description = "Description of the Elastic Beanstalk application"
  default     = ""
}

variable "solution_stack_name" {
  type        = string
  description = "Solution stack name for the Elastic Beanstalk environment"
}

variable "tier" {
  type        = string
  description = "Environment tier"
  default     = "WebServer"

  validation {
    condition     = contains(["WebServer", "Worker"], var.tier)
    error_message = "Tier must be either WebServer or Worker."
  }
}

#==============================================================================
# NETWORK VARIABLES
#==============================================================================

variable "vpc_id" {
  type        = string
  description = "VPC ID for the Elastic Beanstalk environment"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs for the Elastic Beanstalk environment"
}

#==============================================================================
# INSTANCE VARIABLES
#==============================================================================

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances in the Auto Scaling group"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances in the Auto Scaling group"
  default     = 4
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
  default     = ""
}

#==============================================================================
# IAM VARIABLES
#==============================================================================

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile for EC2 instances"
}

variable "service_role" {
  type        = string
  description = "IAM service role for the Elastic Beanstalk environment"
}

#==============================================================================
# ENVIRONMENT CONFIGURATION VARIABLES
#==============================================================================

variable "environment_variables" {
  type        = map(string)
  description = "Map of environment variables to set in the Elastic Beanstalk environment"
  default     = {}
}

variable "settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))
  description = "List of setting objects for fine-grained Elastic Beanstalk configuration"
  default     = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to all resources"
  default     = {}
}
