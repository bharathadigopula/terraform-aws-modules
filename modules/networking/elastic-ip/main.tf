#==============================================================================
# ELASTIC IP ALLOCATION
#==============================================================================

resource "aws_eip" "this" {
  count = var.eip_count

  domain           = var.domain
  public_ipv4_pool = var.public_ipv4_pool

  tags = merge(
    var.tags,
    { Name = var.eip_count > 1 ? "${var.name}-${count.index + 1}" : var.name }
  )
}

#==============================================================================
# EIP ASSOCIATION WITH EC2 INSTANCES
#==============================================================================

resource "aws_eip_association" "instance" {
  count = length(var.instance_ids)

  allocation_id       = aws_eip.this[count.index].id
  instance_id         = var.instance_ids[count.index]
  allow_reassociation = var.allow_reassociation
}

#==============================================================================
# EIP ASSOCIATION WITH NETWORK INTERFACES
#==============================================================================

resource "aws_eip_association" "eni" {
  count = length(var.network_interface_ids)

  allocation_id        = aws_eip.this[count.index].id
  network_interface_id = var.network_interface_ids[count.index]
  private_ip_address   = length(var.private_ips) > count.index ? var.private_ips[count.index] : null
  allow_reassociation  = var.allow_reassociation
}
