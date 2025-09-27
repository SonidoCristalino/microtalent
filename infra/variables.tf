# variables.tf

variable "aws_region" {
  description = "The AWS region where the resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "microtalent-eks-cluster"
}

variable "db_username" {
  description = "Username for the RDS database."
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Password for the RDS database."
  type        = string
  sensitive   = true 
}
