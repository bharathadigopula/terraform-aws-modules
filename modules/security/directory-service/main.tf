#==============================================================================
# DIRECTORY SERVICE
#==============================================================================
resource "aws_directory_service_directory" "this" {
  name     = var.name
  password = var.password
  type     = var.type
  size     = var.type == "SimpleAD" ? var.size : null
  edition  = var.type == "MicrosoftAD" ? var.edition : null

  short_name  = var.short_name
  description = var.description
  alias       = var.alias

  enable_sso = var.enable_sso

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
  }

  tags = var.tags
}

#==============================================================================
# CONDITIONAL FORWARDERS
#==============================================================================
resource "aws_directory_service_conditional_forwarder" "this" {
  for_each = { for f in var.conditional_forwarders : f.remote_domain_name => f }

  directory_id       = aws_directory_service_directory.this.id
  remote_domain_name = each.value.remote_domain_name
  dns_ips            = each.value.dns_ips
}

#==============================================================================
# LOG SUBSCRIPTION
#==============================================================================
resource "aws_directory_service_log_subscription" "this" {
  count = var.cloudwatch_log_group_name != null ? 1 : 0

  directory_id   = aws_directory_service_directory.this.id
  log_group_name = var.cloudwatch_log_group_name
}
