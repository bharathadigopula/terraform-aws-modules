#==============================================================================
# GUARDDUTY DETECTOR
#==============================================================================
resource "aws_guardduty_detector" "this" {
  enable                       = var.enable
  finding_publishing_frequency = var.finding_publishing_frequency

  datasources {
    s3_logs {
      enable = var.enable_s3_logs
    }
    kubernetes {
      audit_logs {
        enable = var.enable_kubernetes_audit_logs
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = var.enable_malware_protection
        }
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# GUARDDUTY ORGANIZATION ADMIN
#==============================================================================
resource "aws_guardduty_organization_admin_account" "this" {
  count = var.admin_account_id != null ? 1 : 0

  admin_account_id = var.admin_account_id
}
