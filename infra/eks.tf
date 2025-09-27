# eks.tf

# 1. EKS Cluster Resource (Control Plane)
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.29" # El argumento aquí sí se llama 'version'

  # Connect the cluster to the VPC and Security Group
  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
  ]
}

# 2. Node Group Resource (Worker Nodes)
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "microtalent-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = module.vpc.private_subnets

  instance_types = ["t3.medium"]
  disk_size      = 20

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
  ]
}
