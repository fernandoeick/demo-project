#!/bin/bash

## Creates all k8s resources as defined in the k8s folder
## Do a port-forward to make the webapp available in the port 8080 in the localhost

SVC_NAME="demo-app-service"

# Defina o caminho do diretório onde seus arquivos YAML estão localizados
YAML_DIR="../k8s"

# Verifique se o diretório existe
if [ -d "$YAML_DIR" ]; then
  echo "Applying all YAML files in $YAML_DIR..."
  
  # Aplicar todos os arquivos YAML no diretório
  kubectl apply -f $YAML_DIR
  
  # Verificar o status dos recursos aplicados
  echo "Checking the status of the resources..."
  kubectl get all
  
  echo "All resources have been applied successfully."

  kubectl port-forward svc/${SVC_NAME} 8080:80

else
  echo "Directory $YAML_DIR does not exist. Please check the path."
  exit 1
fi
