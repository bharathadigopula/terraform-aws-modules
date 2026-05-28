#==============================================================================
# FRONTEND WEB AND MOBILE OUTPUTS
#==============================================================================

output "modules" {
  description = "Outputs from the frontend web and mobile modules"
  value = {
    amplify          = module.amplify
    appsync          = module.appsync
    location_service = module.location_service
  }
}
