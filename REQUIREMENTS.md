# REQUIREMENTS

## Overview

This document provides a comprehensive list of requirements and dependencies for the `demo-project`. Please ensure that all requirements are met to ensure the project functions correctly.

### Docker
Ensure Docker is running and accessible.
You need to be logged in a docker registry to push and pull the docker image.
Replace the docker registry address and the repository name in the following locations: 
- `build_and_deploy_image.sh` and optionally in the `build_and_run_app.sh` in the scripts folder
- `deployment.yaml` and `pod.yaml` in the k8s folder

### Terraform
Ensure Terraform is installed and accessible. We recommend the usage of the terraform version `1.5.5`or later. You can use the `tfenv` to manage terraform versions.
You will need a S3 bucket created for the terraform backend (not provisioned by this stack).
In the `terragrunt.hcl` file in each `env` folder, replace the bucket name by in the remote_state configuration.

### Terragrunt
Terragrunt is used to provide abstraction of the terraform. We recommend the usage of the `tgenv` to manage the terragrunt versions.

### Kubectl
For kubernetes resources management, the `kubectl` must be installed and proper configured. Also, you need to ensure you will have access to the EKS cluster that will be provisioned in the AWS account by terraform.
When the infrastructure is provisioned by the terraform stack, the eks cluster information will be printed in the output. Use that information to update your kubeconfig. eg: `aws eks --region us-east-1 update-kubeconfig --name demo-cluster-sandbox`

### AWS
You need to have access to an AWS account and the `aws cli` proper configured with a profile and the proper access keys. 
