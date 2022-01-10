variable "node_name" {
  type        = string
  description = "Node name"
  default     = "worker"
}

variable "volume_size" {
  type        = number
  description = "Volume size in GB"
  default     = 100
}

variable "volume_type" {
  type        = string
  description = "Volume type"
  default     = "gp2"
}

variable "delete_on_termination" {
  type        = bool
  description = "Delete on termination?"
  default     = true
}

variable "encrypted" {
  type        = bool
  description = "Encrypt volumes?"
  default     = true
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs"
  default     = null
}

variable "image_id" {
  type        = string
  description = "AMI ID"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
}

variable "eks_cluster_auth_base64" {
  type        = string
  description = "Base64-encoded cluster certificate authority data"
}

variable "eks_cluster_iam_role_arn" {
  type        = string
  description = "EKS cluster IAM role ARN"
}

variable "eks_node_bootstrap_extra_args" {
  type        = string
  description = "EKS bootstrap extra arguments"
  default     = ""
}

variable "eks_node_kubelet_extra_args" {
  type        = string
  description = "Kubelet extra arguments"
  default     = ""
}
