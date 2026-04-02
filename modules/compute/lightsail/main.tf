#==============================================================================
# LIGHTSAIL INSTANCE
#==============================================================================

resource "aws_lightsail_instance" "this" {
  name              = var.name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.key_pair_name
  user_data         = var.user_data
  ip_address_type   = var.ip_address_type
  tags              = var.tags
}

#==============================================================================
# LIGHTSAIL STATIC IP
#==============================================================================

resource "aws_lightsail_static_ip" "this" {
  count = var.create_static_ip ? 1 : 0

  name = "${var.name}-static-ip"
}

#==============================================================================
# LIGHTSAIL STATIC IP ATTACHMENT
#==============================================================================

resource "aws_lightsail_static_ip_attachment" "this" {
  count = var.create_static_ip ? 1 : 0

  static_ip_name = aws_lightsail_static_ip.this[0].name
  instance_name  = aws_lightsail_instance.this.name
}

#==============================================================================
# LIGHTSAIL INSTANCE PUBLIC PORTS
#==============================================================================

resource "aws_lightsail_instance_public_ports" "this" {
  count = var.create_public_ports ? 1 : 0

  instance_name = aws_lightsail_instance.this.name

  dynamic "port_info" {
    for_each = var.public_ports

    content {
      from_port = port_info.value.from_port
      to_port   = port_info.value.to_port
      protocol  = port_info.value.protocol
    }
  }
}
