#==============================================================================
# PORTFOLIO OUTPUTS
#==============================================================================
output "portfolio_ids" {
  description = "Map of portfolio names to IDs"
  value       = { for k, v in aws_servicecatalog_portfolio.this : k => v.id }
}

#==============================================================================
# PRODUCT OUTPUTS
#==============================================================================
output "product_ids" {
  description = "Map of product names to IDs"
  value       = { for k, v in aws_servicecatalog_product.this : k => v.id }
}
