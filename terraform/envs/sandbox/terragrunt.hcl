terraform {
  source = "../../stacks//eks"
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

inputs = {
  eks_cluster_name = "demo-cluster"
  eks_version      = "1.30"
  env_name         = "sandbox"

  nodes_desired_size = 2
  nodes_max_size     = 3
  nodes_min_size     = 2

  tags = {
    environment = "sandbox"
    stack       = "eks"
    terraform   = "true"
  }
}

remote_state {
  backend = "s3"
  config = {
    key            = "sandbox/state/sandbox.tfstate"
    bucket         = "demo-project-backend"
    region         = "us-east-1"
    encrypt        = true
  }
}