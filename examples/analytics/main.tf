#==============================================================================
# ANALYTICS EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "analytics"
    },
    var.tags
  )
}

module "athena" {
  source = "../../modules/analytics/athena"

  workgroup_name  = var.athena_workgroup_name
  output_location = var.athena_output_location
  tags            = local.tags
}

module "clean_rooms" {
  source = "../../modules/analytics/clean-rooms"

  name                 = var.clean_rooms_name
  creator_display_name = var.clean_rooms_creator_display_name
  tags                 = local.tags
}

module "data_exchange" {
  source = "../../modules/analytics/data-exchange"

  name = var.data_exchange_name
  tags = local.tags
}

module "data_pipeline" {
  source = "../../modules/analytics/data-pipeline"

  name = var.data_pipeline_name
  tags = local.tags
}

module "datazone" {
  source = "../../modules/analytics/datazone"

  name                  = var.datazone_name
  domain_execution_role = var.datazone_domain_execution_role
  tags                  = local.tags
}

module "emr" {
  source = "../../modules/analytics/emr"

  name                              = var.emr_name
  service_role                      = var.emr_service_role
  subnet_id                         = var.emr_subnet_id
  emr_managed_master_security_group = var.emr_emr_managed_master_security_group
  emr_managed_slave_security_group  = var.emr_emr_managed_slave_security_group
  instance_profile                  = var.emr_instance_profile
  tags                              = local.tags
}

module "firehose" {
  source = "../../modules/analytics/firehose"

  name = var.firehose_name
  tags = local.tags
}

module "flink" {
  source = "../../modules/analytics/flink"

  name                   = var.flink_name
  service_execution_role = var.flink_service_execution_role
  tags                   = local.tags
}

module "glue" {
  source = "../../modules/analytics/glue"

  tags = local.tags
}

module "kinesis" {
  source = "../../modules/analytics/kinesis"

  name = var.kinesis_name
  tags = local.tags
}

module "lake_formation" {
  source = "../../modules/analytics/lake-formation"
}

module "msk" {
  source = "../../modules/analytics/msk"

  cluster_name    = var.msk_cluster_name
  client_subnets  = var.msk_client_subnets
  security_groups = var.msk_security_groups
  tags            = local.tags
}

module "opensearch" {
  source = "../../modules/analytics/opensearch"

  domain_name = var.opensearch_domain_name
  tags        = local.tags
}

module "quicksight" {
  source = "../../modules/analytics/quicksight"

  tags = local.tags
}
