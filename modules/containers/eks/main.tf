#==============================================================================
# EKS CLUSTER
#==============================================================================
resource "aws_eks_cluster" "this" {
  name                      = var.cluster_name
  version                   = var.cluster_version
  role_arn                  = var.role_arn
  enabled_cluster_log_types = var.enabled_cluster_log_types

  #==============================================================================
  # VPC CONFIG
  #==============================================================================
  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  #==============================================================================
  # ENCRYPTION CONFIG
  #==============================================================================
  dynamic "encryption_config" {
    for_each = var.encryption_config != null ? [var.encryption_config] : []

    content {
      provider {
        key_arn = encryption_config.value.provider_key_arn
      }
      resources = encryption_config.value.resources
    }
  }

  #==============================================================================
  # KUBERNETES NETWORK CONFIG
  #==============================================================================
  dynamic "kubernetes_network_config" {
    for_each = var.kubernetes_network_config != null ? [var.kubernetes_network_config] : []

    content {
      service_ipv4_cidr = kubernetes_network_config.value.service_ipv4_cidr
      ip_family         = kubernetes_network_config.value.ip_family
    }
  }

  #==============================================================================
  # ACCESS CONFIG
  #==============================================================================
  dynamic "access_config" {
    for_each = var.access_config != null ? [var.access_config] : []

    content {
      authentication_mode = access_config.value.authentication_mode
    }
  }

  depends_on = [aws_cloudwatch_log_group.this]

  tags = var.tags
}

#==============================================================================
# CLOUDWATCH LOG GROUP FOR CLUSTER LOGS
#==============================================================================
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.log_kms_key_id

  tags = var.tags
}

#==============================================================================
# EKS CLUSTER ADDONS
#==============================================================================
resource "aws_eks_addon" "this" {
  for_each = var.cluster_addons

  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = each.value.addon_version
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  service_account_role_arn    = each.value.service_account_role_arn

  tags = var.tags
}
