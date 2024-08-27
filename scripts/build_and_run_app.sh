#!/bin/bash

## Build the demo-app and run a container using the latest version of the image.

IMAGE_NAME="fernandoeick/demo-app-img"
CONTAINER_NAME="demo-app"
DOCKERFILE_PATH="../docker/"

# Building the image
echo "Building docker image: '$IMAGE_NAME'"
docker build -t "$IMAGE_NAME" "$DOCKERFILE_PATH"

if [ $? -ne 0 ]; then
  echo "Error to build the docker image"
  exit 1
fi

# Check if a container is running. If so, stop it 
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  echo "Stoping existing container: '$CONTAINER_NAME'"
  docker stop "$CONTAINER_NAME"
fi

# Removing old containers
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
  echo "Remove existing container: '$CONTAINER_NAME'"
  docker rm "$CONTAINER_NAME"
fi

# Starting container and exposing local port
echo "Starting the new container: '$CONTAINER_NAME'"
docker run -d -p 8080:80 --name "$CONTAINER_NAME" "$IMAGE_NAME"

# Check if container started successfully
if [ $? -eq 0 ]; then
  echo "Container successfully started: '$CONTAINER_NAME'"
else
  echo "Container could not be started: '$CONTAINER_NAME'."
  exit 1
fi
