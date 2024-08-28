module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access = true
  cluster_name                   = "${var.eks_cluster_name}-${var.env_name}"
  cluster_version                = var.eks_version

  eks_managed_node_groups = {
    eks_node = {
      instance_types = ["t3.medium"]
      min_size       = var.nodes_min_size
      max_size       = var.nodes_max_size
      desired_size   = var.nodes_desired_size
      key_name       = "demo-keypair"
    }
  }
  enable_cluster_creator_admin_permissions = true
  subnet_ids = aws_subnet.public[*].id
  tags       = var.tags
  vpc_id     = aws_vpc.default.id

}
