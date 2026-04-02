#==============================================================================
# ELASTIC BEANSTALK APPLICATION OUTPUTS
#==============================================================================

output "application_name" {
  value       = aws_elastic_beanstalk_application.this.name
  description = "Name of the Elastic Beanstalk application"
}

#==============================================================================
# ELASTIC BEANSTALK ENVIRONMENT OUTPUTS
#==============================================================================

output "environment_id" {
  value       = aws_elastic_beanstalk_environment.this.id
  description = "ID of the Elastic Beanstalk environment"
}

output "environment_name" {
  value       = aws_elastic_beanstalk_environment.this.name
  description = "Name of the Elastic Beanstalk environment"
}

output "endpoint_url" {
  value       = aws_elastic_beanstalk_environment.this.endpoint_url
  description = "URL of the Elastic Beanstalk environment endpoint"
}

output "cname" {
  value       = aws_elastic_beanstalk_environment.this.cname
  description = "CNAME of the Elastic Beanstalk environment"
}

output "autoscaling_groups" {
  value       = aws_elastic_beanstalk_environment.this.autoscaling_groups
  description = "Auto Scaling groups associated with the environment"
}

output "instances" {
  value       = aws_elastic_beanstalk_environment.this.instances
  description = "EC2 instances associated with the environment"
}

output "load_balancers" {
  value       = aws_elastic_beanstalk_environment.this.load_balancers
  description = "Load balancers associated with the environment"
}
