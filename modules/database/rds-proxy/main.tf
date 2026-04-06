#==============================================================================
# RDS Proxy
#==============================================================================
resource "aws_db_proxy" "this" {
  name                   = var.name
  debug_logging          = var.debug_logging
  engine_family          = var.engine_family
  idle_client_timeout    = var.idle_client_timeout
  require_tls            = var.require_tls
  role_arn               = var.role_arn
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids

  dynamic "auth" {
    for_each = var.auth

    content {
      auth_scheme = auth.value.auth_scheme
      description = auth.value.description
      iam_auth    = auth.value.iam_auth
      secret_arn  = auth.value.secret_arn
    }
  }

  tags = var.tags
}

#==============================================================================
# RDS Proxy Default Target Group
#==============================================================================
resource "aws_db_proxy_default_target_group" "this" {
  db_proxy_name = aws_db_proxy.this.name

  connection_pool_config {
    connection_borrow_timeout    = var.connection_pool_config.connection_borrow_timeout
    max_connections_percent      = var.connection_pool_config.max_connections_percent
    max_idle_connections_percent = var.connection_pool_config.max_idle_connections_percent
  }
}

#==============================================================================
# RDS Proxy Target - DB Instance
#==============================================================================
resource "aws_db_proxy_target" "instance" {
  count = var.target_db_instance_identifier != null ? 1 : 0

  db_proxy_name          = aws_db_proxy.this.name
  target_group_name      = aws_db_proxy_default_target_group.this.name
  db_instance_identifier = var.target_db_instance_identifier
}

#==============================================================================
# RDS Proxy Target - DB Cluster
#==============================================================================
resource "aws_db_proxy_target" "cluster" {
  count = var.target_db_cluster_identifier != null ? 1 : 0

  db_proxy_name         = aws_db_proxy.this.name
  target_group_name     = aws_db_proxy_default_target_group.this.name
  db_cluster_identifier = var.target_db_cluster_identifier
}
