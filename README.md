# Demo App

This repository is composed by the following components:

## The App Folder
Creates a containerized docker application. The `demo-app` is just a web page composed of a single HTML file. The html webpage is deployed in a container made from the nginx base image and exposed to port 80.<br>
A Jenkinsfile is also available in the app folder, which creates a pipeline that will provide all the stages to build and push the image to the proper docker registry. Also, perform the deploy to the Kubernetes cluster.

## The K8s Folder
Creates the minimal Kubernetes cluster resources. Provides a deployment with a replicaset, a pod definition and a service configuration which will expose the nginx that running the web application.<br>
Complementary to that, it is available the hpa definition, to provide the auto-scalation of the pods, using the CPU metric.

## The Terraform Folder
The terraform code is provisioning the requested AWS resources: a `vpc`, `subnets` public and private, an `internet gateway`, the `route tables` and its `associations`. Using this networking, the terraform will provision an `eks` cluster running in the version `1.30`. The `eks` cluster will be composed by 2 nodes as the minimum desired and 3 nodes  as the maximum desired.<br>
The code that is creating the networking and eks are in the `stacks` subfolder<br>
Terragrunt is being used along with Terraform to provide a better abstraction. See the `envs` folder.<br>
The configured backend is a S3 bucket.

## The Scripts Folder
The `scripts` folder contains some useful scripts to play with the solution proposed:
- `build_and_deploy_image.sh`: this script will build the docker image and will push the docker image to the remote registry
- `build_and_run_app.sh`: this script will build the docker image and will run a container using that image. It is ideal to validate the container and the application code, running and validating it locally before promoting.
- `create_k8s_resources.sh`: this script will create all the kubernetes components defined in the `k8s` folder
- `destroy_k8s_resources.sh`: this script will destroy all the kubernetes components defined in the `k8s` folder
- `generate_load.sh`: this script will emulate a high traffic in the eks cluster to force the pods to scale according the metrics defined in the `hpa.yaml`
- `shutdown_app.sh`: this script will stop and remove all the containers to cleanup all the trash generated as result of multiple executions

## How do I Run It?
To make everything up and available, execute the following <b>three</b> commands:

1. In the terraform folder:
- Navigate to: `envs/sandbox`
- Execute: `terragrunt init`, then `terragrunt plan` and finally `terragrunt apply`
- <b>Before you run</b>: Make sure the S3 bucket described in the requirements already exists
- It will create an EKS cluster available in the AWS and all related infrastructure. This code takes around ~10 to ~15 minutes to finish
- Save the `cluster_endpoint` printed in the output for later usage

2. In the scripts folder:
- Execute: `./build_and_deploy_image.sh`
- It will generate the docker image and will upload the image to the docker registry
- <b>Before you run</b>: Make sure to replace the docker registry and repository information as described in the requirements

3. Still in the scripts folder:
- Execute: `./create_k8s_resources.sh`
- It will create all the kubernetes components in the eks cluster previous provisioned
- It will make the webapp available in your localhost in the port 8080 by doing a port-forward of the service
- <b>Before you run</b>: configure your `kubectl context` using the cluster endpoint

Bonus: If you have a Jenkins instance runnning: 
- You can create a Jenkins pipeline with the Jenkinsfile available in the `app` folder
- The Jenkins pipeline will automate all the build and deploy steps
- Terraform should run prior the Jenkins pipeline
