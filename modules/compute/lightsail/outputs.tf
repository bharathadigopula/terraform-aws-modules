#==============================================================================
# LIGHTSAIL INSTANCE OUTPUTS
#==============================================================================

output "instance_name" {
  value       = aws_lightsail_instance.this.name
  description = "Name of the Lightsail instance"
}

output "instance_arn" {
  value       = aws_lightsail_instance.this.arn
  description = "ARN of the Lightsail instance"
}

output "public_ip_address" {
  value       = aws_lightsail_instance.this.public_ip_address
  description = "Public IP address of the Lightsail instance"
}

output "private_ip_address" {
  value       = aws_lightsail_instance.this.private_ip_address
  description = "Private IP address of the Lightsail instance"
}

output "static_ip_address" {
  value       = var.create_static_ip ? aws_lightsail_static_ip.this[0].ip_address : null
  description = "Static IP address attached to the instance"
}

output "created_at" {
  value       = aws_lightsail_instance.this.created_at
  description = "Timestamp when the instance was created"
}
