#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# ECR VARIABLES
#==============================================================================

variable "ecr_name" {
  description = "Value for the name input of the ecr module"
  type        = any
}

#==============================================================================
# ECS CLUSTER VARIABLES
#==============================================================================

variable "ecs_cluster_name" {
  description = "Value for the name input of the ecs-cluster module"
  type        = any
}

#==============================================================================
# ECS FARGATE VARIABLES
#==============================================================================

variable "ecs_fargate_family" {
  description = "Value for the family input of the ecs-fargate module"
  type        = any
}

variable "ecs_fargate_execution_role_arn" {
  description = "Value for the execution_role_arn input of the ecs-fargate module"
  type        = any
}

variable "ecs_fargate_task_role_arn" {
  description = "Value for the task_role_arn input of the ecs-fargate module"
  type        = any
}

variable "ecs_fargate_container_definitions" {
  description = "Value for the container_definitions input of the ecs-fargate module"
  type        = any
}

#==============================================================================
# ECS SERVICE VARIABLES
#==============================================================================

variable "ecs_service_name" {
  description = "Value for the name input of the ecs-service module"
  type        = any
}

variable "ecs_service_cluster_arn" {
  description = "Value for the cluster_arn input of the ecs-service module"
  type        = any
}

variable "ecs_service_task_definition_arn" {
  description = "Value for the task_definition_arn input of the ecs-service module"
  type        = any
}

#==============================================================================
# EKS VARIABLES
#==============================================================================

variable "eks_cluster_name" {
  description = "Value for the cluster_name input of the eks module"
  type        = any
}

variable "eks_cluster_version" {
  description = "Value for the cluster_version input of the eks module"
  type        = any
}

variable "eks_role_arn" {
  description = "Value for the role_arn input of the eks module"
  type        = any
}

variable "eks_subnet_ids" {
  description = "Value for the subnet_ids input of the eks module"
  type        = any
}

#==============================================================================
# EKS NODE GROUP VARIABLES
#==============================================================================

variable "eks_node_group_node_group_name" {
  description = "Value for the node_group_name input of the eks-node-group module"
  type        = any
}

variable "eks_node_group_cluster_name" {
  description = "Value for the cluster_name input of the eks-node-group module"
  type        = any
}

variable "eks_node_group_node_role_arn" {
  description = "Value for the node_role_arn input of the eks-node-group module"
  type        = any
}

variable "eks_node_group_subnet_ids" {
  description = "Value for the subnet_ids input of the eks-node-group module"
  type        = any
}
