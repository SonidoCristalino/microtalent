# security_groups.tf

# Security Group for the EKS Cluster Control Plane itself
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for the EKS control plane."
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "EKS-Cluster-SG"
  }
}

# Security Group for the EKS Worker Nodes
resource "aws_security_group" "eks_nodes_sg" {
  name        = "eks-nodes-sg"
  description = "Security group for the EKS worker nodes."
  vpc_id      = module.vpc.vpc_id

  # Allow nodes to receive traffic from the cluster control plane
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.eks_cluster_sg.id]
  }

  # Allow SSH access ONLY from your public IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EKS-Nodes-SG"
  }
}

# Allow cluster to send traffic to the nodes
resource "aws_security_group_rule" "cluster_to_node" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_nodes_sg.id
}

# Security Group for the RDS Database
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow access to the PostgreSQL database."
  vpc_id      = module.vpc.vpc_id

  # Ingress Rule: Allow connections on port 5432 (PostgreSQL)
  # ONLY from the EKS nodes.
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_nodes_sg.id]
  }

  # Egress Rule: Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-PostgreSQL-SG"
  }
}
