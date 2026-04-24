#==============================================================================
# DATA EXCHANGE DATA SET
#==============================================================================
resource "aws_dataexchange_data_set" "this" {
  asset_type  = var.asset_type
  description = var.description
  name        = var.name

  tags = var.tags
}

#==============================================================================
# DATA EXCHANGE REVISION
#==============================================================================
resource "aws_dataexchange_revision" "this" {
  for_each = { for r in var.revisions : r.comment => r }

  data_set_id = aws_dataexchange_data_set.this.id
  comment     = each.value.comment

  tags = merge(var.tags, each.value.tags)
}
