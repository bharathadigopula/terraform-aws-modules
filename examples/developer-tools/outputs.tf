#==============================================================================
# DEVELOPER TOOLS OUTPUTS
#==============================================================================

output "modules" {
  description = "Outputs from the developer tools modules"
  value = {
    codeartifact = module.codeartifact
    codebuild    = module.codebuild
    codecatalyst = module.codecatalyst
    codecommit   = module.codecommit
    codedeploy   = module.codedeploy
    codepipeline = module.codepipeline
    fis          = module.fis
    xray         = module.xray
  }
}
