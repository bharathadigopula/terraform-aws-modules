#==============================================================================
# STEP FUNCTIONS STATE MACHINE
#==============================================================================
resource "aws_sfn_state_machine" "this" {
  name       = var.name
  role_arn   = var.role_arn
  definition = var.definition
  type       = var.type

  logging_configuration {
    log_destination        = var.log_destination
    include_execution_data = var.include_execution_data
    level                  = var.log_level
  }

  tracing_configuration {
    enabled = var.tracing_enabled
  }

  tags = var.tags
}
