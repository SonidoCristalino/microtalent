# outputs.tf

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = aws_eks_cluster.my_cluster.endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.my_cluster.name
}

# This output generates the exact command to configure kubectl.
output "configure_kubectl" {
  description = "Command to configure kubectl for the created cluster."
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${aws_eks_cluster.my_cluster.name}"
}
