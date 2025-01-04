#!/usr/bin/bash

# 1) Change ownership of docker socket - required to access docker daemon on Windows Host
sudo chown $USER:docker /var/run/docker.sock

# 2) Call init-dev.sh
bash scripts/init-dev.sh