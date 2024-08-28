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
  env_name         = "production"

  nodes_desired_size = 4
  nodes_max_size     = 5
  nodes_min_size     = 4

  tags = {
    environment = "production"
    stack       = "eks"
    terraform   = "true"
  }
}

remote_state {
  backend = "s3"
  config = {
    key            = "production/state/production.tfstate"
    bucket         = "demo-project-backend"
    region         = "us-east-1"
    encrypt        = true
  }
}