
# The below is used when no custom LT is defined
resource "aws_launch_template" "this" {
  name_prefix            = "eks-${var.node_name}-"
  description            = "Launch template for ${var.node_name}"
  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = var.delete_on_termination
      encrypted             = var.encrypted

      # Enable this if you want to encrypt your node root volumes with a KMS/CMK. encryption of PVCs is handled via k8s StorageClass tho
      # you also need to attach data.aws_iam_policy_document.ebs_decryption.json from the disk_encryption_policy.tf to the KMS/CMK key then !!
      # kms_key_id            = var.kms_key_arn
    }
  }

  # instance_type = var.instance_type

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = var.security_groups
  }

  # if you want to use a custom AMI
  image_id = var.image_id

  # If you use a custom AMI, you need to supply via user-data, the bootstrap script as EKS DOESNT merge its managed user-data then
  # you can add more than the minimum code you see in the template, e.g. install SSM agent, see https://github.com/aws/containers-roadmap/issues/593#issuecomment-577181345
  #
  # (optionally you can use https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/cloudinit_config to render the script, example: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/997#issuecomment-705286151)

  user_data = base64encode(
    templatefile("${path.module}/templates/userdata.sh.tpl", local.launch_template_userdata_config)
  )

  # # Supplying custom tags to EKS instances is another use-case for LaunchTemplates
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.node_name}"
    }
  }

  # # Supplying custom tags to EKS instances root volumes is another use-case for LaunchTemplates. (doesnt add tags to dynamically provisioned volumes via PVC tho)
  # tag_specifications {
  #   resource_type = "volume"

  #   tags = {
  #     CustomTag = "EKS example"
  #   }
  # }

  # # Tag the LT itself
  # tags = {
  #   CustomTag = "EKS example"
  # }

  lifecycle {
    create_before_destroy = true
  }
}
