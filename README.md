# Demo App

This repository is composed by the following components:

## Docker
Creates a containerized application. `demo-app` is just a webpage composed by a single html file. The html webpage is deployed in a container created from the `nginx` base image and it is exposed to the port 80. The `Jenkinsfile` creates the pipeline that will be building the docker image, pushing it to the docker registry and then deploys it to the kubernetes deployment.

## k8s
Creates a minimal kubernetes cluster resources. It provided a deployment, ready to get the docker image pushed to the docker registry. The deployment is setting the replicaset set to the value 3. This k8s components folder are also providing the pod and the service, that will expose the nginx service.
Complementar to that, we are providing the installation of the metrics server and and hpa to provide pods auto scalation using the cpu metric.

## Terraform
Provision in the aws the minimal needed resources to create an eks cluster. Terraform is creating: 1 vpc, 1 private subnet, 2 public subnets, the route tables and the associations and the eks cluster. The eks cluster is being provisioned using the version `1.30` and it will create 2 nodes minimun and 2 nodes max.
The terraform backend is a S3 bucket.

## Script
Contains some useful scripts:
- `build_and_run_app.sh`: script will build the docker image and will run a container from that image. It is ideal to validate the container and the application code, running and validating it locally before promoting.
- `shutdown_app.sh`: stop and remove all containers to clean all the trash generated from multiple executions
- `deploy_image.sh`: will push the docker image created to the remote registry
- `create_k8s_resources.sh`: it will create all the kubernetes componentes defined in the `k8s` folder
- `destroy_k8s_resources.sh`: it will destroy all the kubernetes componentes defined in the `k8s` folder
- `generate_load.sh`: will emulate a high traffic in the cluster to force the pods to scale according the metrics defined in the `hpa.yaml`

## Execution Order
To make everything available locally execute the following commands in this order:

In the scripts folder:
`./scripts/build_and_run_app.sh` and then `./scripts/deploy_image.sh`

In the terraform folder:
Navigate to: `envs/sandbox`
Execute: `terragrunt init`, then `terragrunt plan` and finally `terragrunt apply`
It will make a EKS cluster available in the AWS. This code takes around ~10 to ~15 minutes to finish

In the scripts folder again:
`./creates_k8s_resources.sh` to create all the kubernetes componentes in the eks cluster provisioned.
It will make the webapp available in your localhost in the port 8080

If you have a Jenkins instance runnning, you can create a Jenkins pipeline with the Jenkinsfile available. The Jenkins file will provide all this steps as automated stages. Terraform should run prior the Jenkins pipeline.