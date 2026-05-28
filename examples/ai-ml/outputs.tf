#==============================================================================
# AI AND MACHINE LEARNING OUTPUTS
#==============================================================================

output "modules" {
  description = "Outputs from the AI and machine learning modules"
  value = {
    bedrock     = module.bedrock
    comprehend  = module.comprehend
    forecast    = module.forecast
    lex         = module.lex
    personalize = module.personalize
    rekognition = module.rekognition
    sagemaker   = module.sagemaker
    textract    = module.textract
  }
}
