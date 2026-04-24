#==============================================================================
# DATA PIPELINE
#==============================================================================
resource "aws_datapipeline_pipeline" "this" {
  name        = var.name
  description = var.description

  tags = var.tags
}

#==============================================================================
# DATA PIPELINE DEFINITION
#==============================================================================
resource "aws_datapipeline_pipeline_definition" "this" {
  count = length(var.pipeline_objects) > 0 ? 1 : 0

  pipeline_id = aws_datapipeline_pipeline.this.id

  dynamic "pipeline_object" {
    for_each = var.pipeline_objects
    content {
      id   = pipeline_object.value.id
      name = pipeline_object.value.name

      dynamic "field" {
        for_each = pipeline_object.value.fields
        content {
          key          = field.value.key
          string_value = field.value.string_value
          ref_value    = field.value.ref_value
        }
      }
    }
  }

  dynamic "parameter_object" {
    for_each = var.parameter_objects
    content {
      id = parameter_object.value.id

      dynamic "attribute" {
        for_each = parameter_object.value.attributes
        content {
          key          = attribute.value.key
          string_value = attribute.value.string_value
        }
      }
    }
  }

  dynamic "parameter_value" {
    for_each = var.parameter_values
    content {
      id           = parameter_value.value.id
      string_value = parameter_value.value.string_value
    }
  }
}
