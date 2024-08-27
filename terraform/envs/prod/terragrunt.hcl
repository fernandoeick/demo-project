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
  backend_bucket_name = "eickhoff-tf-backend"
  backend_state_file  = "production/state/production.tfstate"

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