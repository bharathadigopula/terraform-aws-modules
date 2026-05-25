#==============================================================================
# CODEPIPELINE PIPELINES
#==============================================================================

resource "aws_codepipeline" "this" {
  for_each = { for pipeline in var.pipelines : pipeline.name => pipeline }

  name           = each.value.name
  role_arn       = each.value.role_arn
  pipeline_type  = each.value.pipeline_type
  execution_mode = each.value.execution_mode
  tags           = merge(var.tags, each.value.tags)

  dynamic "artifact_store" {
    for_each = each.value.artifact_stores

    content {
      location = artifact_store.value.location
      type     = artifact_store.value.type
      region   = artifact_store.value.region

      dynamic "encryption_key" {
        for_each = artifact_store.value.encryption_key != null ? [artifact_store.value.encryption_key] : []

        content {
          id   = encryption_key.value.id
          type = encryption_key.value.type
        }
      }
    }
  }

  dynamic "stage" {
    for_each = each.value.stages

    content {
      name = stage.value.name

      dynamic "action" {
        for_each = stage.value.actions

        content {
          name               = action.value.name
          category           = action.value.category
          owner              = action.value.owner
          provider           = action.value.provider
          version            = action.value.version
          configuration      = action.value.configuration
          input_artifacts    = action.value.input_artifacts
          output_artifacts   = action.value.output_artifacts
          namespace          = action.value.namespace
          region             = action.value.region
          role_arn           = action.value.role_arn
          run_order          = action.value.run_order
          timeout_in_minutes = action.value.timeout_in_minutes
        }
      }
    }
  }

  dynamic "variable" {
    for_each = each.value.variables

    content {
      name          = variable.value.name
      default_value = variable.value.default_value
      description   = variable.value.description
    }
  }
}
