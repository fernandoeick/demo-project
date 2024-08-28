# Install metrics-server
# kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Generate http requests
# while true; do curl http://localhost:8080; done


#!/bin/bash

# Command to execute in each pod
COMMAND="yes > /dev/null"

# Get the list of all pods in the specified namespace
PODS=$(kubectl get pods -l app=demo-app -o jsonpath="{.items[*].metadata.name}")

# Loop through each pod and execute the command
for POD in $PODS; do
    echo "Executing command in pod: $POD"
    kubectl exec -it $POD -- /bin/sh -c "$COMMAND"
done
