FROM mibreit/mibreit-fullstack:0.5.0

ARG UID=${UID:-1000}
ARG GID=${GID:-1000}
ARG USER=${USER:-developer}

ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN groupadd -g $GID $USER && \
  useradd -d /home/$USER -s /bin/bash -m $USER -l -u $UID -g $GID && \
  echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER

# Install MongoDB Shell (mongosh)
RUN <<EOF
mkdir -p /home/developer/.local/bin
cd /home/developer/.local/bin
curl -fsSL https://raw.githubusercontent.com/mongodb-js/mongosh/refs/heads/main/download_latest.sh | sh
cd -
EOF

# Highlight Branch in Bash
RUN echo "parse_git_branch() {" >> ~/.bashrc && \
  echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> ~/.bashrc && \
  echo "}" >> ~/.bashrc && \
  echo "export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ '" >> ~/.bashrc

# Completion for Taskfile
RUN echo 'eval "$(task --completion bash)"' --completion bash >> ~/.bashrc

# Update path
ENV PATH="$PATH:/home/developer/.local/bin"

# Create KUBECONFIG from contents of .kube
RUN echo "export KUBECONFIG=\$(find ~/.kube -maxdepth 1 -type f | tr '\n' ':')" >> ~/.bashrc

# Create kubectl alias
RUN echo "alias k='kubectl'" >> ~/.bashrc && \
  echo "alias python3='python3.11'" >> ~/.bashrc && \
  echo "alias python='python3.11'" >> ~/.bashrc

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sleep", "infinity"]