#==============================================================================
# SAGEMAKER NOTEBOOK VARIABLES
#==============================================================================

variable "notebook_instances" {
  description = "List of SageMaker notebook instances to create"
  type = list(object({
    name                                      = string
    role_arn                                  = string
    instance_type                             = string
    subnet_id                                 = optional(string)
    security_groups                           = optional(set(string))
    kms_key_id                                = optional(string)
    lifecycle_config_name                     = optional(string)
    direct_internet_access                    = optional(string)
    root_access                               = optional(string)
    volume_size                               = optional(number)
    default_code_repository                   = optional(string)
    additional_code_repositories              = optional(set(string))
    platform_identifier                       = optional(string)
    minimum_instance_metadata_service_version = optional(string)
    tags                                      = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# SAGEMAKER MODEL VARIABLES
#==============================================================================

variable "models" {
  description = "List of SageMaker models to create"
  type = list(object({
    name                     = string
    execution_role_arn       = string
    enable_network_isolation = optional(bool)
    primary_container = optional(object({
      image                        = optional(string)
      model_data_url               = optional(string)
      model_package_name           = optional(string)
      container_hostname           = optional(string)
      environment                  = optional(map(string))
      mode                         = optional(string)
      inference_specification_name = optional(string)
    }))
    vpc_config = optional(object({
      subnets            = set(string)
      security_group_ids = set(string)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# SAGEMAKER ENDPOINT CONFIGURATION VARIABLES
#==============================================================================

variable "endpoint_configurations" {
  description = "List of SageMaker endpoint configurations to create"
  type = list(object({
    name               = optional(string)
    name_prefix        = optional(string)
    kms_key_arn        = optional(string)
    execution_role_arn = optional(string)
    production_variants = list(object({
      variant_name                                      = optional(string)
      model_name                                        = optional(string)
      instance_type                                     = optional(string)
      initial_instance_count                            = optional(number)
      initial_variant_weight                            = optional(number)
      accelerator_type                                  = optional(string)
      container_startup_health_check_timeout_in_seconds = optional(number)
      model_data_download_timeout_in_seconds            = optional(number)
      enable_ssm_access                                 = optional(bool)
      inference_ami_version                             = optional(string)
      volume_size_in_gb                                 = optional(number)
      serverless_config = optional(object({
        max_concurrency         = number
        memory_size_in_mb       = number
        provisioned_concurrency = optional(number)
      }))
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# SAGEMAKER ENDPOINT VARIABLES
#==============================================================================

variable "endpoints" {
  description = "List of SageMaker endpoints to create"
  type = list(object({
    name                 = string
    endpoint_config_name = string
    tags                 = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
