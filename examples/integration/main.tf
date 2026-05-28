#==============================================================================
# INTEGRATION EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "integration"
    },
    var.tags
  )
}

module "appflow" {
  source = "../../modules/integration/appflow"

  name                       = var.appflow_name
  source_connector_type      = var.appflow_source_connector_type
  destination_connector_type = var.appflow_destination_connector_type
  tags                       = local.tags
}

module "eventbridge" {
  source = "../../modules/integration/eventbridge"

  tags = local.tags
}

module "mq" {
  source = "../../modules/integration/mq"

  broker_name    = var.mq_broker_name
  engine_version = var.mq_engine_version
  users          = var.mq_users
  tags           = local.tags
}

module "mwaa" {
  source = "../../modules/integration/mwaa"

  name               = var.mwaa_name
  execution_role_arn = var.mwaa_execution_role_arn
  source_bucket_arn  = var.mwaa_source_bucket_arn
  security_group_ids = var.mwaa_security_group_ids
  subnet_ids         = var.mwaa_subnet_ids
  tags               = local.tags
}

module "sns" {
  source = "../../modules/integration/sns"

  name = var.sns_name
  tags = local.tags
}

module "sqs" {
  source = "../../modules/integration/sqs"

  name = var.sqs_name
  tags = local.tags
}

module "step_functions" {
  source = "../../modules/integration/step-functions"

  name       = var.step_functions_name
  role_arn   = var.step_functions_role_arn
  definition = var.step_functions_definition
  tags       = local.tags
}

module "swf" {
  source = "../../modules/integration/swf"

  name = var.swf_name
  tags = local.tags
}
