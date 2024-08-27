# REQUIREMENTS

## Overview

This document provides a comprehensive list of requirements and dependencies for the `demo-project`. Please ensure that all requirements are met to ensure the project functions correctly.

### Docker
Ensure Docker is running and accessible.

### Terraform
Ensure Terraform is installed and accessible. We recommend the usage of the terraform version 1.5.5. You can use the `tfenv` to manage terraform versions.

### Terragrunt
Terragrunt is used to provide abstraction of the terraform. We recommend the usage of the `tgenv` to manage the terragrunt versions.

### Kubectl
For kubernetes resources management, the `kubectl` must be installed and proper configured. Also, you need to ensure you will have access to the EKS cluster that will be provisioned in the AWS account. 

### AWS
You need to have access to an AWS account and the `aws cli` proper configured with a profile and needed keys to access the resource using the cli. 
