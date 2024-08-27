#!/bin/bash

## Destroy all k8s resources as defined in the k8s folder

YAML_DIR="../k8s"

if [ -d "$YAML_DIR" ]; then
  echo "Applying all YAML files in $YAML_DIR..."
  
  kubectl delete -f $YAML_DIR
  
  echo "Checking the status of the resources..."
  kubectl get all
  
  echo "All resources have been destroyed successfully."
else
  echo "Directory $YAML_DIR does not exist. Please check the path."
  exit 1
fi
