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
# CODEARTIFACT VARIABLES
#==============================================================================

variable "codeartifact_domains" {
  description = "CodeArtifact domains to create"
  type        = list(any)
  default     = []
}

variable "codeartifact_repositories" {
  description = "CodeArtifact repositories to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# CODEBUILD VARIABLES
#==============================================================================

variable "codebuild_projects" {
  description = "CodeBuild projects to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# CODECATALYST VARIABLES
#==============================================================================

variable "codecatalyst_projects" {
  description = "CodeCatalyst projects to create"
  type        = list(any)
  default     = []
}

variable "codecatalyst_source_repositories" {
  description = "CodeCatalyst source repositories to create"
  type        = list(any)
  default     = []
}

variable "codecatalyst_dev_environments" {
  description = "CodeCatalyst dev environments to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# CODECOMMIT VARIABLES
#==============================================================================

variable "codecommit_repositories" {
  description = "CodeCommit repositories to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# CODEDEPLOY VARIABLES
#==============================================================================

variable "codedeploy_applications" {
  description = "CodeDeploy applications to create"
  type        = list(any)
  default     = []
}

variable "codedeploy_deployment_groups" {
  description = "CodeDeploy deployment groups to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# CODEPIPELINE VARIABLES
#==============================================================================

variable "codepipeline_pipelines" {
  description = "CodePipeline pipelines to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# FIS VARIABLES
#==============================================================================

variable "fis_experiment_templates" {
  description = "FIS experiment templates to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# XRAY VARIABLES
#==============================================================================

variable "xray_encryption_config" {
  description = "X-Ray encryption configuration"
  type        = any
  default     = null
}

variable "xray_groups" {
  description = "X-Ray groups to create"
  type        = list(any)
  default     = []
}

variable "xray_sampling_rules" {
  description = "X-Ray sampling rules to create"
  type        = list(any)
  default     = []
}
