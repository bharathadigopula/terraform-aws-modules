#==============================================================================
# CODECATALYST PROJECTS
#==============================================================================

resource "aws_codecatalyst_project" "this" {
  for_each = { for project in var.projects : project.name => project }

  space_name   = each.value.space_name
  display_name = each.value.display_name
  description  = each.value.description
}

#==============================================================================
# CODECATALYST SOURCE REPOSITORIES
#==============================================================================

resource "aws_codecatalyst_source_repository" "this" {
  for_each = { for repository in var.source_repositories : repository.name => repository }

  space_name   = each.value.space_name
  project_name = try(aws_codecatalyst_project.this[each.value.project_name].name, each.value.project_name)
  name         = each.value.name
  description  = each.value.description
}

#==============================================================================
# CODECATALYST DEV ENVIRONMENTS
#==============================================================================

resource "aws_codecatalyst_dev_environment" "this" {
  for_each = { for environment in var.dev_environments : environment.name => environment }

  space_name                 = each.value.space_name
  project_name               = try(aws_codecatalyst_project.this[each.value.project_name].name, each.value.project_name)
  instance_type              = each.value.instance_type
  alias                      = each.value.alias
  inactivity_timeout_minutes = each.value.inactivity_timeout_minutes

  persistent_storage {
    size = each.value.persistent_storage_size
  }

  ides {
    name    = each.value.ide.name
    runtime = each.value.ide.runtime
  }

  dynamic "repositories" {
    for_each = each.value.repositories

    content {
      repository_name = repositories.value.repository_name
      branch_name     = repositories.value.branch_name
    }
  }
}
