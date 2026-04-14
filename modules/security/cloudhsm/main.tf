#==============================================================================
# CLOUDHSM CLUSTER
#==============================================================================
resource "aws_cloudhsm_v2_cluster" "this" {
  hsm_type   = var.hsm_type
  subnet_ids = var.subnet_ids

  source_backup_identifier = var.source_backup_identifier

  tags = var.tags
}

#==============================================================================
# CLOUDHSM INSTANCES
#==============================================================================
resource "aws_cloudhsm_v2_hsm" "this" {
  for_each = { for idx, h in var.hsm_instances : idx => h }

  cluster_id        = aws_cloudhsm_v2_cluster.this.cluster_id
  availability_zone = each.value.availability_zone
  ip_address        = each.value.ip_address
}
