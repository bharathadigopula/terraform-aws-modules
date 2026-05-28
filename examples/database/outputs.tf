#==============================================================================
# DATABASE OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "aurora",
    "dms",
    "documentdb",
    "dynamodb",
    "elasticache",
    "keyspaces",
    "memorydb",
    "neptune",
    "rds",
    "rds_proxy",
    "redshift",
    "timestream",
  ]
}
