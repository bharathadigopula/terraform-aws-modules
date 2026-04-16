#==============================================================================
# STATE MACHINE OUTPUTS
#==============================================================================
output "state_machine_id" {
  description = "ID of the state machine"
  value       = aws_sfn_state_machine.this.id
}

output "state_machine_arn" {
  description = "ARN of the state machine"
  value       = aws_sfn_state_machine.this.arn
}

output "state_machine_name" {
  description = "Name of the state machine"
  value       = aws_sfn_state_machine.this.name
}

output "creation_date" {
  description = "Creation date of the state machine"
  value       = aws_sfn_state_machine.this.creation_date
}

output "status" {
  description = "Status of the state machine"
  value       = aws_sfn_state_machine.this.status
}
