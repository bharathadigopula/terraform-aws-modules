#==============================================================================
# TRANSFER FAMILY SERVERS
#==============================================================================

resource "aws_transfer_server" "this" {
  for_each = { for server in var.servers : server.name => server }

  certificate                      = each.value.certificate
  directory_id                     = each.value.directory_id
  domain                           = each.value.domain
  endpoint_type                    = "VPC"
  force_destroy                    = each.value.force_destroy
  function                         = each.value.function
  host_key                         = each.value.host_key
  identity_provider_type           = each.value.identity_provider_type
  invocation_role                  = each.value.invocation_role
  logging_role                     = each.value.logging_role
  post_authentication_login_banner = each.value.post_authentication_login_banner
  pre_authentication_login_banner  = each.value.pre_authentication_login_banner
  protocols                        = each.value.protocols
  security_policy_name             = "TransferSecurityPolicy-2025-03"
  sftp_authentication_methods      = each.value.sftp_authentication_methods
  structured_log_destinations      = each.value.structured_log_destinations
  url                              = each.value.url
  tags                             = merge(var.tags, each.value.tags)

  dynamic "endpoint_details" {
    for_each = each.value.endpoint_details != null ? [each.value.endpoint_details] : []

    content {
      address_allocation_ids = endpoint_details.value.address_allocation_ids
      security_group_ids     = endpoint_details.value.security_group_ids
      subnet_ids             = endpoint_details.value.subnet_ids
      vpc_endpoint_id        = endpoint_details.value.vpc_endpoint_id
      vpc_id                 = endpoint_details.value.vpc_id
    }
  }

  dynamic "protocol_details" {
    for_each = each.value.protocol_details != null ? [each.value.protocol_details] : []

    content {
      as2_transports              = protocol_details.value.as2_transports
      passive_ip                  = protocol_details.value.passive_ip
      set_stat_option             = protocol_details.value.set_stat_option
      tls_session_resumption_mode = protocol_details.value.tls_session_resumption_mode
    }
  }

  dynamic "s3_storage_options" {
    for_each = each.value.s3_storage_options != null ? [each.value.s3_storage_options] : []

    content {
      directory_listing_optimization = s3_storage_options.value.directory_listing_optimization
    }
  }
}

#==============================================================================
# TRANSFER FAMILY USERS
#==============================================================================

resource "aws_transfer_user" "this" {
  for_each = { for user in var.users : user.name => user }

  server_id           = each.value.server_name != null ? aws_transfer_server.this[each.value.server_name].id : each.value.server_id
  user_name           = each.value.name
  role                = each.value.role
  home_directory      = each.value.home_directory
  home_directory_type = each.value.home_directory_type
  policy              = each.value.policy
  tags                = merge(var.tags, each.value.tags)

  dynamic "home_directory_mappings" {
    for_each = each.value.home_directory_mappings

    content {
      entry  = home_directory_mappings.value.entry
      target = home_directory_mappings.value.target
    }
  }

  dynamic "posix_profile" {
    for_each = each.value.posix_profile != null ? [each.value.posix_profile] : []

    content {
      uid            = posix_profile.value.uid
      gid            = posix_profile.value.gid
      secondary_gids = posix_profile.value.secondary_gids
    }
  }
}

#==============================================================================
# TRANSFER FAMILY SSH KEYS
#==============================================================================

resource "aws_transfer_ssh_key" "this" {
  for_each = { for key in var.ssh_keys : key.name => key }

  server_id = each.value.server_name != null ? aws_transfer_server.this[each.value.server_name].id : each.value.server_id
  user_name = each.value.user_name
  body      = each.value.body
}
