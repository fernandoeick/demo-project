#!/bin/bash

## Upload the demo-app-img to the remote registry tagged as latest.

DOCKERFILE_PATH="../app/"
IMAGE_NAME="demo-app-img"
IMAGE_TAG="latest"
REGISTRY="docker.io"
REPOSITORY="fernandoeick"
FULL_IMAGE_NAME="${REGISTRY}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"

# Building the image
echo "Building docker image: '$IMAGE_NAME'"
docker build -t "$REPOSITORY/$IMAGE_NAME" "$DOCKERFILE_PATH"

if [ $? -ne 0 ]; then
  echo "Error to build the docker image"
  exit 1
fi

echo "Logging into the registry..."
docker login $REGISTRY

# Enviar a imagem para o registro
echo "Pushing Docker image to the registry..."
docker push ${FULL_IMAGE_NAME}

# Mensagem de sucesso
echo "Docker image pushed successfully: ${FULL_IMAGE_NAME}"
