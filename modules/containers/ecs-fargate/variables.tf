#==============================================================================
# ECS FARGATE TASK DEFINITION VARIABLES
#==============================================================================
variable "family" {
  description = "A unique name for the task definition family"
  type        = string
}

variable "cpu" {
  description = "Number of CPU units used by the task (256, 512, 1024, 2048, 4096)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Amount of memory in MiB used by the task"
  type        = number
  default     = 512
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "execution_role_arn" {
  description = "ARN of the task execution role that grants the ECS agent permission to pull images and publish logs"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the IAM role that allows the task containers to call AWS services"
  type        = string
}

variable "container_definitions" {
  description = "JSON encoded string of container definitions for the task"
  type        = string
}

variable "runtime_platform" {
  description = "Configuration for the task runtime platform including CPU architecture and OS family"
  type = object({
    cpu_architecture        = optional(string, "X86_64")
    operating_system_family = optional(string, "LINUX")
  })
  default = null
}

variable "volumes" {
  description = "List of volume definitions with EFS configuration for the task"
  type = list(object({
    name = string
    efs_volume_configuration = object({
      file_system_id     = string
      root_directory     = optional(string, "/")
      transit_encryption = optional(string, "ENABLED")
      authorization_config = optional(object({
        access_point_id = optional(string)
        iam             = optional(string, "ENABLED")
      }))
    })
  }))
  default = []
}

variable "ephemeral_storage_size_gib" {
  description = "Size in GiB of ephemeral storage for the task (21-200 for Fargate)"
  type        = number
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to the task definition"
  type        = map(string)
  default     = {}
}
