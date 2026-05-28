#==============================================================================
# CONTAINERS EXAMPLE
#==============================================================================

provider "aws" {
  region = var.aws_region
}

locals {
  tags = merge(
    {
      ManagedBy = "Terraform"
      Example   = "containers"
    },
    var.tags
  )
}

module "ecr" {
  source = "../../modules/containers/ecr"

  name = var.ecr_name
  tags = local.tags
}

module "ecs_cluster" {
  source = "../../modules/containers/ecs-cluster"

  name = var.ecs_cluster_name
  tags = local.tags
}

module "ecs_fargate" {
  source = "../../modules/containers/ecs-fargate"

  family                = var.ecs_fargate_family
  execution_role_arn    = var.ecs_fargate_execution_role_arn
  task_role_arn         = var.ecs_fargate_task_role_arn
  container_definitions = var.ecs_fargate_container_definitions
  tags                  = local.tags
}

module "ecs_service" {
  source = "../../modules/containers/ecs-service"

  name                = var.ecs_service_name
  cluster_arn         = var.ecs_service_cluster_arn
  task_definition_arn = var.ecs_service_task_definition_arn
  tags                = local.tags
}

module "eks" {
  source = "../../modules/containers/eks"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  role_arn        = var.eks_role_arn
  subnet_ids      = var.eks_subnet_ids
  tags            = local.tags
}

module "eks_node_group" {
  source = "../../modules/containers/eks-node-group"

  node_group_name = var.eks_node_group_node_group_name
  cluster_name    = var.eks_node_group_cluster_name
  node_role_arn   = var.eks_node_group_node_role_arn
  subnet_ids      = var.eks_node_group_subnet_ids
  tags            = local.tags
}
