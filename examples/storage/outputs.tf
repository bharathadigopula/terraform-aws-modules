#==============================================================================
# STORAGE OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "backup",
    "ebs",
    "efs",
    "fsx_lustre",
    "fsx_ontap",
    "fsx_openzfs",
    "fsx_windows",
    "s3",
    "s3_replication",
    "storage_gateway",
  ]
}
