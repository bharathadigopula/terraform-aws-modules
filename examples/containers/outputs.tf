#==============================================================================
# CONTAINERS OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "ecr",
    "ecs_cluster",
    "ecs_fargate",
    "ecs_service",
    "eks",
    "eks_node_group",
  ]
}
