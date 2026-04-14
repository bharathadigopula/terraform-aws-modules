#==============================================================================
# DIRECTORY OUTPUTS
#==============================================================================
output "directory_id" {
  description = "ID of the directory"
  value       = aws_directory_service_directory.this.id
}

output "dns_ip_addresses" {
  description = "DNS IP addresses of the directory"
  value       = aws_directory_service_directory.this.dns_ip_addresses
}

output "access_url" {
  description = "Access URL for the directory"
  value       = aws_directory_service_directory.this.access_url
}

output "security_group_id" {
  description = "Security group ID created by the directory"
  value       = aws_directory_service_directory.this.security_group_id
}
