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
# BEDROCK VARIABLES
#==============================================================================

variable "bedrock_model_invocation_logging_config" {
  description = "Bedrock model invocation logging configuration"
  type        = any
  default     = null
}

variable "bedrock_guardrails" {
  description = "Bedrock guardrails to create"
  type        = list(any)
  default     = []
}

variable "bedrock_agents" {
  description = "Bedrock agents to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# COMPREHEND VARIABLES
#==============================================================================

variable "comprehend_document_classifiers" {
  description = "Comprehend document classifiers to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# FORECAST VARIABLES
#==============================================================================

variable "forecast_resources" {
  description = "Forecast Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# LEX VARIABLES
#==============================================================================

variable "lex_bots" {
  description = "Lex V2 bots to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# PERSONALIZE VARIABLES
#==============================================================================

variable "personalize_resources" {
  description = "Personalize Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# REKOGNITION VARIABLES
#==============================================================================

variable "rekognition_collections" {
  description = "Rekognition collections to create"
  type        = list(any)
  default     = []
}

variable "rekognition_projects" {
  description = "Rekognition projects to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# SAGEMAKER VARIABLES
#==============================================================================

variable "sagemaker_notebook_instances" {
  description = "SageMaker notebook instances to create"
  type        = list(any)
  default     = []
}

variable "sagemaker_models" {
  description = "SageMaker models to create"
  type        = list(any)
  default     = []
}

variable "sagemaker_endpoint_configurations" {
  description = "SageMaker endpoint configurations to create"
  type        = list(any)
  default     = []
}

variable "sagemaker_endpoints" {
  description = "SageMaker endpoints to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# TEXTRACT VARIABLES
#==============================================================================

variable "textract_resources" {
  description = "Textract Cloud Control resources to create"
  type        = list(any)
  default     = []
}
