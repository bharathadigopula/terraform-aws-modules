#==============================================================================
# FIREHOSE OUTPUTS
#==============================================================================
output "delivery_stream_id" {
  description = "ID of the Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.id
}

output "delivery_stream_arn" {
  description = "ARN of the Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.arn
}

output "delivery_stream_name" {
  description = "Name of the Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.name
}

output "version_id" {
  description = "Version ID of the delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.this.version_id
}
