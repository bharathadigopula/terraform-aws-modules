#==============================================================================
# AI AND MACHINE LEARNING EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "ai-ml"
    },
    var.tags
  )
}

module "bedrock" {
  source = "../../modules/ai-ml/bedrock"

  model_invocation_logging_config = var.bedrock_model_invocation_logging_config
  guardrails                      = var.bedrock_guardrails
  agents                          = var.bedrock_agents
  tags                            = local.tags
}

module "comprehend" {
  source = "../../modules/ai-ml/comprehend"

  document_classifiers = var.comprehend_document_classifiers
  tags                 = local.tags
}

module "forecast" {
  source = "../../modules/ai-ml/forecast"

  resources = var.forecast_resources
}

module "lex" {
  source = "../../modules/ai-ml/lex"

  bots = var.lex_bots
  tags = local.tags
}

module "personalize" {
  source = "../../modules/ai-ml/personalize"

  resources = var.personalize_resources
}

module "rekognition" {
  source = "../../modules/ai-ml/rekognition"

  collections = var.rekognition_collections
  projects    = var.rekognition_projects
  tags        = local.tags
}

module "sagemaker" {
  source = "../../modules/ai-ml/sagemaker"

  notebook_instances      = var.sagemaker_notebook_instances
  models                  = var.sagemaker_models
  endpoint_configurations = var.sagemaker_endpoint_configurations
  endpoints               = var.sagemaker_endpoints
  tags                    = local.tags
}

module "textract" {
  source = "../../modules/ai-ml/textract"

  resources = var.textract_resources
}
