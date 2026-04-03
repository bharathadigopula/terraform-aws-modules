#==============================================================================
# LOCAL VALUES
#==============================================================================

locals {
  role_arn = var.create_role ? aws_iam_role.lambda[0].arn : var.role_arn
}

#==============================================================================
# IAM ROLE
#==============================================================================

data "aws_iam_policy_document" "assume_role" {
  count = var.create_role ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count = var.create_role ? 1 : 0

  name               = "${var.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda" {
  count = var.create_role ? length(var.policy_arns) : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
  count = var.create_role && var.vpc_config != null ? 1 : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  count = var.create_role ? 1 : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#==============================================================================
# LAMBDA FUNCTION
#==============================================================================

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description   = var.description
  role          = local.role_arn

  handler     = var.handler
  runtime     = var.runtime
  timeout     = var.timeout
  memory_size = var.memory_size

  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version
  source_code_hash  = var.source_code_hash

  layers                         = length(var.layers) > 0 ? var.layers : null
  publish                        = var.publish
  architectures                  = var.architectures
  package_type                   = var.package_type
  image_uri                      = var.image_uri
  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_key_arn
  code_signing_config_arn        = var.code_signing_config_arn

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [var.vpc_config] : []

    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [var.environment_variables] : []

    content {
      variables = environment.value
    }
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config != null ? [var.dead_letter_config] : []

    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }

  tracing_config {
    mode = var.tracing_config_mode
  }

  dynamic "image_config" {
    for_each = var.image_config != null ? [var.image_config] : []

    content {
      command           = image_config.value.command
      entry_point       = image_config.value.entry_point
      working_directory = image_config.value.working_directory
    }
  }

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage_size != null ? [var.ephemeral_storage_size] : []

    content {
      size = ephemeral_storage.value
    }
  }

  depends_on = [aws_cloudwatch_log_group.this]

  tags = var.tags
}

#==============================================================================
# CLOUDWATCH LOG GROUP
#==============================================================================

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.tags
}

#==============================================================================
# LAMBDA PERMISSIONS (ALLOWED TRIGGERS)
#==============================================================================

resource "aws_lambda_permission" "triggers" {
  for_each = var.allowed_triggers

  statement_id   = each.key
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.this.function_name
  principal      = each.value.principal
  source_arn     = each.value.source_arn
  source_account = each.value.source_account
}

#==============================================================================
# EVENT SOURCE MAPPINGS
#==============================================================================

resource "aws_lambda_event_source_mapping" "this" {
  count = length(var.event_source_mappings)

  function_name     = aws_lambda_function.this.arn
  event_source_arn  = var.event_source_mappings[count.index].event_source_arn
  batch_size        = var.event_source_mappings[count.index].batch_size
  starting_position = var.event_source_mappings[count.index].starting_position
  enabled           = var.event_source_mappings[count.index].enabled

  dynamic "filter_criteria" {
    for_each = var.event_source_mappings[count.index].filter_criteria != null ? [var.event_source_mappings[count.index].filter_criteria] : []

    content {
      dynamic "filter" {
        for_each = filter_criteria.value

        content {
          pattern = filter.value
        }
      }
    }
  }
}
