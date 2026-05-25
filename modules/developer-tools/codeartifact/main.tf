#==============================================================================
# CODEARTIFACT DOMAINS
#==============================================================================

resource "aws_codeartifact_domain" "this" {
  for_each = { for domain in var.domains : domain.name => domain }

  domain         = each.value.name
  encryption_key = each.value.encryption_key
  tags           = merge(var.tags, each.value.tags)
}

#==============================================================================
# CODEARTIFACT REPOSITORIES
#==============================================================================

resource "aws_codeartifact_repository" "this" {
  for_each = { for repository in var.repositories : repository.name => repository }

  repository   = each.value.name
  domain       = try(aws_codeartifact_domain.this[each.value.domain].domain, each.value.domain)
  domain_owner = each.value.domain_owner
  description  = each.value.description
  tags         = merge(var.tags, each.value.tags)

  dynamic "external_connections" {
    for_each = each.value.external_connection_name != null ? [each.value.external_connection_name] : []

    content {
      external_connection_name = external_connections.value
    }
  }

  dynamic "upstream" {
    for_each = each.value.upstream_repositories

    content {
      repository_name = upstream.value
    }
  }
}
