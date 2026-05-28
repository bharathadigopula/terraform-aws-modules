#==============================================================================
# DATABASE EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "database"
    },
    var.tags
  )
}

module "aurora" {
  source = "../../modules/database/aurora"

  cluster_identifier = var.aurora_cluster_identifier
  engine             = var.aurora_engine
  engine_version     = var.aurora_engine_version
  instance_class     = var.aurora_instance_class
  master_username    = var.aurora_master_username
  master_password    = var.aurora_master_password
  tags               = local.tags
}

module "dms" {
  source = "../../modules/database/dms"

  replication_instance_id    = var.dms_replication_instance_id
  replication_instance_class = var.dms_replication_instance_class
  tags                       = local.tags
}

module "documentdb" {
  source = "../../modules/database/documentdb"

  cluster_identifier     = var.documentdb_cluster_identifier
  engine_version         = var.documentdb_engine_version
  instance_class         = var.documentdb_instance_class
  db_subnet_group_name   = var.documentdb_db_subnet_group_name
  vpc_security_group_ids = var.documentdb_vpc_security_group_ids
  master_username        = var.documentdb_master_username
  master_password        = var.documentdb_master_password
  tags                   = local.tags
}

module "dynamodb" {
  source = "../../modules/database/dynamodb"

  name       = var.dynamodb_name
  hash_key   = var.dynamodb_hash_key
  attributes = var.dynamodb_attributes
  tags       = local.tags
}

module "elasticache" {
  source = "../../modules/database/elasticache"

  replication_group_id = var.elasticache_replication_group_id
  description          = var.elasticache_description
  engine               = var.elasticache_engine
  node_type            = var.elasticache_node_type
  tags                 = local.tags
}

module "keyspaces" {
  source = "../../modules/database/keyspaces"

  keyspace_name = var.keyspaces_keyspace_name
  tags          = local.tags
}

module "memorydb" {
  source = "../../modules/database/memorydb"

  name      = var.memorydb_name
  node_type = var.memorydb_node_type
  acl_name  = var.memorydb_acl_name
  tags      = local.tags
}

module "neptune" {
  source = "../../modules/database/neptune"

  cluster_identifier = var.neptune_cluster_identifier
  instance_class     = var.neptune_instance_class
  tags               = local.tags
}

module "rds" {
  source = "../../modules/database/rds"

  identifier        = var.rds_identifier
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  username          = var.rds_username
  password          = var.rds_password
  tags              = local.tags
}

module "rds_proxy" {
  source = "../../modules/database/rds-proxy"

  name                   = var.rds_proxy_name
  engine_family          = var.rds_proxy_engine_family
  role_arn               = var.rds_proxy_role_arn
  vpc_subnet_ids         = var.rds_proxy_vpc_subnet_ids
  vpc_security_group_ids = var.rds_proxy_vpc_security_group_ids
  auth                   = var.rds_proxy_auth
  tags                   = local.tags
}

module "redshift" {
  source = "../../modules/database/redshift"

  cluster_identifier = var.redshift_cluster_identifier
  node_type          = var.redshift_node_type
  database_name      = var.redshift_database_name
  master_username    = var.redshift_master_username
  master_password    = var.redshift_master_password
  tags               = local.tags
}

module "timestream" {
  source = "../../modules/database/timestream"

  database_name = var.timestream_database_name
  tags          = local.tags
}
