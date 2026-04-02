#==============================================================================
# PLACEMENT GROUP
#==============================================================================

resource "aws_placement_group" "this" {
  name            = var.name
  strategy        = var.strategy
  partition_count = var.strategy == "partition" ? var.partition_count : null
  spread_level    = var.strategy == "spread" ? var.spread_level : null

  tags = var.tags
}
