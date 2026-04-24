#==============================================================================
# STREAM OUTPUTS
#==============================================================================
output "stream_id" {
  description = "ID of the Kinesis stream"
  value       = aws_kinesis_stream.this.id
}

output "stream_arn" {
  description = "ARN of the Kinesis stream"
  value       = aws_kinesis_stream.this.arn
}

output "stream_name" {
  description = "Name of the Kinesis stream"
  value       = aws_kinesis_stream.this.name
}

#==============================================================================
# CONSUMER OUTPUTS
#==============================================================================
output "consumer_arns" {
  description = "Map of consumer names to ARNs"
  value       = { for k, v in aws_kinesis_stream_consumer.this : k => v.arn }
}
