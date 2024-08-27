variable "backend_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the terraform backend"
}

variable "backend_state_file" {
  type        = string
  description = "The name of the file for the terraform state"
}

variable "env_name" {
  type        = string
  description = "The name of the environment"
}

variable "eks_cluster_name" {
  type        = string
  description = "The name to be used to identify the eks cluster created"
}

variable "eks_version" {
  type        = string
  description = "The eks version to be used to create the eks cluster"
  default     = "1.30"
}

variable "region" {
  type        = string
  description = "The AWS region"
  default     = "us-east-1"
}

variable "nodes_desired_size" {
  type        = number
  description = "The desired size for the eks cluster nodes"
  default     = 2
}

variable "nodes_max_size" {
  type        = number
  description = "The max size for the eks cluster nodes"
  default     = 3
}

variable "nodes_min_size" {
  type        = number
  description = "The min size for the eks cluster nodes"
  default     = 2
}

variable "tags" {
  description = "Tags to apply to all resources."
  default     = {}
  type        = map(any)
}

