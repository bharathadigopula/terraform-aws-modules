#==============================================================================
# SERVICE CATALOG PORTFOLIO
#==============================================================================
resource "aws_servicecatalog_portfolio" "this" {
  for_each = { for p in var.portfolios : p.name => p }

  name          = each.value.name
  description   = each.value.description
  provider_name = each.value.provider_name

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# SERVICE CATALOG PRODUCT
#==============================================================================
resource "aws_servicecatalog_product" "this" {
  for_each = { for p in var.products : p.name => p }

  name        = each.value.name
  owner       = each.value.owner
  description = each.value.description
  type        = each.value.type
  distributor = each.value.distributor

  provisioning_artifact_parameters {
    name                        = each.value.artifact_name
    description                 = each.value.artifact_description
    type                        = each.value.artifact_type
    template_url                = each.value.template_url
    disable_template_validation = each.value.disable_template_validation
  }

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# PORTFOLIO PRODUCT ASSOCIATION
#==============================================================================
resource "aws_servicecatalog_product_portfolio_association" "this" {
  for_each = {
    for item in flatten([
      for p in var.products : [
        for portfolio in p.portfolio_names : {
          key          = "${p.name}-${portfolio}"
          product_id   = aws_servicecatalog_product.this[p.name].id
          portfolio_id = aws_servicecatalog_portfolio.this[portfolio].id
        }
      ]
    ]) : item.key => item
  }

  product_id   = each.value.product_id
  portfolio_id = each.value.portfolio_id
}

#==============================================================================
# PORTFOLIO PRINCIPAL ASSOCIATION
#==============================================================================
resource "aws_servicecatalog_principal_portfolio_association" "this" {
  for_each = {
    for item in flatten([
      for p in var.portfolios : [
        for principal in p.principal_arns : {
          key          = "${p.name}-${principal}"
          portfolio_id = aws_servicecatalog_portfolio.this[p.name].id
          principal    = principal
        }
      ]
    ]) : item.key => item
  }

  portfolio_id  = each.value.portfolio_id
  principal_arn = each.value.principal
}
