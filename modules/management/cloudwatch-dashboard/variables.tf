#==============================================================================
# DASHBOARD VARIABLES
#==============================================================================
variable "dashboards" {
  description = "List of CloudWatch dashboards to create"
  type = list(object({
    name = string
    body = string
  }))
  default = []
}
