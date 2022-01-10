locals {
  launch_template_userdata_config = {
    cluster_name        = var.eks_cluster_name
    endpoint            = var.eks_cluster_endpoint
    cluster_auth_base64 = var.eks_cluster_auth_base64

    bootstrap_extra_args = var.eks_node_bootstrap_extra_args
    kubelet_extra_args   = var.eks_node_kubelet_extra_args
  }
}
