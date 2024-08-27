#!/bin/bash

## Upload the demo-app-img to the remote registry tagged as latest.

IMAGE_NAME="demo-app-img"
IMAGE_TAG="latest"
REGISTRY="docker.io"
REPOSITORY="fernandoeick"
FULL_IMAGE_NAME="${REGISTRY}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "Logging into the registry..."
docker login $REGISTRY

# Enviar a imagem para o registro
echo "Pushing Docker image to the registry..."
docker push ${FULL_IMAGE_NAME}

# Mensagem de sucesso
echo "Docker image pushed successfully: ${FULL_IMAGE_NAME}"
