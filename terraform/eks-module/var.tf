variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
variable "cluster_version" {
  description = "Version of the EKS cluster"
  type        = string
  default     = "1.27"
}
variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be created"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
variable "node_groups" {
  description = "Map of node group configurations"
  type = map(object({
    instance_type = string
    desired_capacity = number
    max_size = number
    min_size = number
    key_name = string
  }))
  default = {}
}
variable "environment" {
  description = "Environment for the EKS cluster (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

