# Demo App

This repository is composed by the following components:

## The App Folder
Creates a containerized docker application. The `demo-app` is just a web page composed of a single HTML file. The html webpage is deployed in a container made from the nginx base image and exposed to port 80. 
The Jenkinsfile available in the app folder, creates a pipeline that will provide all the needed stages to build the docker image, to push it to the proper docker registry, and then to deploy it to the Kubernetes cluster.

## The K8s Resources
Available in the `k8s` folder, it creates the minimal Kubernetes cluster resources. It provides a deployment, which is ready to get the docker image previously pushed to the docker registry. The ReplicaSet is also created as well as a service, which will expose the nginx running the web application.
Complementary to that, we are providing the installation of the metrics-server and hpa to provide auto scalation of the pods, using the CPU metric.

## The Terraform Components
Using Terragrunt to create an abstraction, it will provision in the `aws` the minimal resources needed to create an `eks` cluster. The Terraform available is creating the following resources: `vpc`, `a private subnet`, `public subnets`in two different availability zones, the `route tables`, the `route tables associations` and the `eks` cluster.
The eks cluster is provisioned using the version `1.30` and the cluster will be composed by `2 nodes min` and `3 nodes max`.
Terraform backend is using a S3 bucket.

## The Scripts
The `scripts` folder contains some useful scripts:
- `build_and_deploy_image.sh`: this script will build the docker image and then will push the docker image to the remote registry
- `build_and_run_app.sh`: script will build the docker image and will run a container from that image. It is ideal to validate the container and the application code, running and validating it locally before promoting.
- `create_k8s_resources.sh`: it will create all the kubernetes componentes defined in the `k8s` folder
- `destroy_k8s_resources.sh`: it will destroy all the kubernetes componentes defined in the `k8s` folder
- `generate_load.sh`: will emulate a high traffic in the cluster to force the pods to scale according the metrics defined in the `hpa.yaml`
- `shutdown_app.sh`: stop and remove all containers to clean all the trash generated from multiple executions

## Execution Order
To make everything available locally execute the following commands in this strict order:

In the terraform folder:
- Navigate to: `envs/sandbox`
- Execute: `terragrunt init`, then `terragrunt plan` and finally `terragrunt apply`
- It will make a EKS cluster available in the AWS. This code takes around ~10 to ~15 minutes to finish

In the scripts folder:
- Execute: `./scripts/build_and_deploy_image.sh`
- It will generate the docker image and will upload it to the registry

Still in the scripts folder:
- Execute: `./creates_k8s_resources.sh`
- It will create all the kubernetes components in the eks cluster previous provisioned
- It will make the webapp available in your localhost in the port 8080 by doing a port-forward of the service

If you have a Jenkins instance runnning: 
- You can create a Jenkins pipeline with the Jenkinsfile available in the `app`folder
- The Jenkins pipeline will automate all the build and deploy steps
- Terraform should run prior the Jenkins pipeline anyway

## Improvements
We need to make the docker registry easier to maintain. Currently, the registry and the repository information are defined in three or four different locations in the code. To replace the current registry and repository we need to find and change all occurrences in the code. 