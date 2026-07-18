#!/bin/bash
set -e

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

if [ "${DOCKER_GID}" != "0" ]; then
    if ! getent group docker >/dev/null; then
        sudo groupadd -g "${DOCKER_GID}" docker
    else
        sudo groupmod -g "${DOCKER_GID}" docker
    fi
    sudo usermod -aG docker "$USER"
fi

sudo usermod -aG docker "$USER"

# uncomment if you have node modules
# sudo chown $USER:$USER /home/$USER/develop/node_modules

exec "$@"
