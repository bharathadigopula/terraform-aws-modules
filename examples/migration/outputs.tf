#==============================================================================
# MIGRATION AND TRANSFER OUTPUTS
#==============================================================================

output "modules" {
  description = "Outputs from the migration and transfer modules"
  value = {
    application_migration = module.application_migration
    datasync              = module.datasync
    migration_hub         = module.migration_hub
    snow_family           = module.snow_family
    transfer_family       = module.transfer_family
  }
}
