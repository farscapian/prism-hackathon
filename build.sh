#!/bin/bash

set -ex

docker pull "polarlightning/clightning:23.02.2"

if [[ $(docker ps -q | wc -l) -gt 0 ]]; then
    echo "WARNING! You have existing containers running."
    exit 1
else
    docker system prune -f
fi

# build the docker image which contains dependencies for cln plugin prism.py
CLN_IMAGE_NAME="roygbiv/clightning"
CLN_IMAGE_TAG="23.02.2"
docker build -t "$CLN_IMAGE_NAME:$CLN_IMAGE_TAG" .


echo "Your image '$CLN_IMAGE_NAME:$CLN_IMAGE_TAG' has been updated."
