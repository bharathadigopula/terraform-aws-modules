#==============================================================================
# LICENSE CONFIGURATION
#==============================================================================
resource "aws_licensemanager_license_configuration" "this" {
  for_each = { for lc in var.license_configurations : lc.name => lc }

  name                     = each.value.name
  description              = each.value.description
  license_count            = each.value.license_count
  license_count_hard_limit = each.value.license_count_hard_limit
  license_counting_type    = each.value.license_counting_type

  license_rules = each.value.license_rules

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# LICENSE ASSOCIATION
#==============================================================================
resource "aws_licensemanager_association" "this" {
  for_each = {
    for item in flatten([
      for lc in var.license_configurations : [
        for arn in lc.resource_arns : {
          key                = "${lc.name}-${arn}"
          license_config_arn = aws_licensemanager_license_configuration.this[lc.name].arn
          resource_arn       = arn
        }
      ]
    ]) : item.key => item
  }

  license_configuration_arn = each.value.license_config_arn
  resource_arn              = each.value.resource_arn
}
