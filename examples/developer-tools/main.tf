#==============================================================================
# DEVELOPER TOOLS EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "developer-tools"
    },
    var.tags
  )
}

module "codeartifact" {
  source = "../../modules/developer-tools/codeartifact"

  domains      = var.codeartifact_domains
  repositories = var.codeartifact_repositories
  tags         = local.tags
}

module "codebuild" {
  source = "../../modules/developer-tools/codebuild"

  projects = var.codebuild_projects
  tags     = local.tags
}

module "codecatalyst" {
  source = "../../modules/developer-tools/codecatalyst"

  projects            = var.codecatalyst_projects
  source_repositories = var.codecatalyst_source_repositories
  dev_environments    = var.codecatalyst_dev_environments
}

module "codecommit" {
  source = "../../modules/developer-tools/codecommit"

  repositories = var.codecommit_repositories
  tags         = local.tags
}

module "codedeploy" {
  source = "../../modules/developer-tools/codedeploy"

  applications      = var.codedeploy_applications
  deployment_groups = var.codedeploy_deployment_groups
  tags              = local.tags
}

module "codepipeline" {
  source = "../../modules/developer-tools/codepipeline"

  pipelines = var.codepipeline_pipelines
  tags      = local.tags
}

module "fis" {
  source = "../../modules/developer-tools/fis"

  experiment_templates = var.fis_experiment_templates
  tags                 = local.tags
}

module "xray" {
  source = "../../modules/developer-tools/xray"

  encryption_config = var.xray_encryption_config
  groups            = var.xray_groups
  sampling_rules    = var.xray_sampling_rules
  tags              = local.tags
}
