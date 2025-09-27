# vpc.tf

# We use the Terraform module to create a VPC with public and private subnets.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = "microtalent-vpc"
  cidr = "10.0.0.0/16"

  # Define the availability zones and subnets
  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Enable a NAT Gateway so that resources in private subnets
  # (like the EKS nodes) can access the internet.
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
