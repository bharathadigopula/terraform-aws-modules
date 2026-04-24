#==============================================================================
# EMR CLUSTER
#==============================================================================
resource "aws_emr_cluster" "this" {
  name          = var.name
  release_label = var.release_label
  applications  = var.applications
  log_uri       = var.log_uri

  service_role                      = var.service_role
  autoscaling_role                  = var.autoscaling_role
  scale_down_behavior               = var.scale_down_behavior
  visible_to_all_users              = var.visible_to_all_users
  termination_protection            = var.termination_protection
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps

  ec2_attributes {
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.emr_managed_master_security_group
    emr_managed_slave_security_group  = var.emr_managed_slave_security_group
    instance_profile                  = var.instance_profile
    key_name                          = var.key_name
  }

  master_instance_group {
    instance_type  = var.master_instance_type
    instance_count = var.master_instance_count

    ebs_config {
      size                 = var.master_ebs_size
      type                 = var.master_ebs_type
      volumes_per_instance = var.master_ebs_volumes_per_instance
    }
  }

  core_instance_group {
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count
    bid_price      = var.core_bid_price

    ebs_config {
      size                 = var.core_ebs_size
      type                 = var.core_ebs_type
      volumes_per_instance = var.core_ebs_volumes_per_instance
    }
  }

  dynamic "kerberos_attributes" {
    for_each = var.kerberos_realm != null ? [1] : []
    content {
      kdc_admin_password = var.kdc_admin_password
      realm              = var.kerberos_realm
    }
  }

  security_configuration = var.security_configuration

  tags = var.tags
}

#==============================================================================
# EMR SECURITY CONFIGURATION
#==============================================================================
resource "aws_emr_security_configuration" "this" {
  count = var.security_config_json != null ? 1 : 0

  name          = "${var.name}-security-config"
  configuration = var.security_config_json
}
