#==============================================================================
# GLUE CATALOG DATABASE
#==============================================================================
resource "aws_glue_catalog_database" "this" {
  for_each = { for db in var.databases : db.name => db }

  name         = each.value.name
  description  = each.value.description
  location_uri = each.value.location_uri
  parameters   = each.value.parameters
}

#==============================================================================
# GLUE CRAWLER
#==============================================================================
resource "aws_glue_crawler" "this" {
  for_each = { for c in var.crawlers : c.name => c }

  name          = each.value.name
  description   = each.value.description
  database_name = each.value.database_name
  role          = each.value.role_arn
  schedule      = each.value.schedule
  table_prefix  = each.value.table_prefix

  dynamic "s3_target" {
    for_each = each.value.s3_targets
    content {
      path       = s3_target.value.path
      exclusions = s3_target.value.exclusions
    }
  }

  dynamic "jdbc_target" {
    for_each = each.value.jdbc_targets
    content {
      connection_name = jdbc_target.value.connection_name
      path            = jdbc_target.value.path
      exclusions      = jdbc_target.value.exclusions
    }
  }

  schema_change_policy {
    delete_behavior = each.value.delete_behavior
    update_behavior = each.value.update_behavior
  }

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# GLUE JOB
#==============================================================================
resource "aws_glue_job" "this" {
  for_each = { for j in var.jobs : j.name => j }

  name              = each.value.name
  description       = each.value.description
  role_arn          = each.value.role_arn
  glue_version      = each.value.glue_version
  worker_type       = each.value.worker_type
  number_of_workers = each.value.number_of_workers
  timeout           = each.value.timeout
  max_retries       = each.value.max_retries

  command {
    name            = each.value.command_name
    script_location = each.value.script_location
    python_version  = each.value.python_version
  }

  default_arguments = each.value.default_arguments

  dynamic "execution_property" {
    for_each = each.value.max_concurrent_runs != null ? [1] : []
    content {
      max_concurrent_runs = each.value.max_concurrent_runs
    }
  }

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# GLUE TRIGGER
#==============================================================================
resource "aws_glue_trigger" "this" {
  for_each = { for t in var.triggers : t.name => t }

  name     = each.value.name
  type     = each.value.type
  schedule = each.value.schedule
  enabled  = each.value.enabled

  dynamic "actions" {
    for_each = each.value.actions
    content {
      job_name  = actions.value.job_name
      arguments = actions.value.arguments
      timeout   = actions.value.timeout
    }
  }

  tags = merge(var.tags, each.value.tags)
}
