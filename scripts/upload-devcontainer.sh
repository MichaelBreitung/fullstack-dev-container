#!/usr/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASE_DIR=$( cd "$SCRIPT_DIR/.." &> /dev/null && pwd )

# 1) Ensure that a version parameter is provided
if [ -z "$1" ]; then
    echo "Error: No version provided. Please provide a version in the format X.Y.Z."
    exit 1
fi

VERSION="${1}"

# TODO: Use your custom BASE_REGISTRY_PATH here -> you won't be able to push to the mibreit registry
BASE_REGISTRY_PATH=mibreit/mibreit-fullstack
BASE_IMAGE_TAG="${BASE_REGISTRY_PATH}:${VERSION}"
BASE_IMAGE_LATEST_TAG="${BASE_REGISTRY_PATH}:latest"

# 2) Make sure the version is unique
if docker pull "$BASE_IMAGE_TAG"; then
    echo "Error: The version $VERSION already exists for the Base Development Image in the registry. Make sure to use a unique version, higher than the last one."
    exit 1
fi

# 3) build and deploy
cd "$BASE_DIR/.devcontainer"
echo "Building Base Development Image and pushing it to ${BASE_IMAGE_TAG}."
docker image build -t "$BASE_IMAGE_TAG" -f Dockerfile.base .
docker push "$BASE_IMAGE_TAG"
docker tag "$BASE_IMAGE_TAG" "$BASE_IMAGE_LATEST_TAG"
docker push "$BASE_IMAGE_LATEST_TAG"  
cd -
