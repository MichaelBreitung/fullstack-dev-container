# Dev Container Image

The "Dockerfile.base" defines the basic Dev Container image for Fullstack Development. 
All required tools are included.

The "Dockerfile" is based on this base image, adds a user, and sets up the environment.

## Publishing a new base image

Whenever new tools are required for the development, the base image must be updated. 

For it:

1) Update the "Dockerfile.base" and make sure to use fixed versions during installation. 
2) If you aren't already, login to docker hub: `docker login`.
3) Call `./scripts/upload-devcontainer.sh` with a new version.
4) The Dockerfile will use the "latest" version per default when you rebuild the Dev Container.
