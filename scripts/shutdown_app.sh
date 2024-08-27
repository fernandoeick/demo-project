#!/bin/bash

## Stop and remove all running docker containers to perform a cleanup.

container_ids=$(docker ps -q)

if [ -z "$container_ids" ]; then
  echo "No containers were find to stop"
else
  echo "Stoping the following containers:"
  for container_id in $container_ids; do
    echo "Stopping container:: $container_id"
    docker stop "$container_id"
    echo "Removing container:: $container_id"
    docker rm "$container_id"
  done
fi
