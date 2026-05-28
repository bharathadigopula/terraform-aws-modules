#==============================================================================
# SECURITY OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "acm",
    "audit_manager",
    "cloudhsm",
    "cognito",
    "detective",
    "directory_service",
    "firewall_manager",
    "guardduty",
    "iam",
    "iam_identity_center",
    "inspector",
    "kms",
    "macie",
    "ram",
    "secrets_manager",
    "security_hub",
    "security_lake",
    "shield",
    "verified_permissions",
    "waf",
  ]
}
