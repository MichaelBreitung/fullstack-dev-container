FROM mibreit/mibreit-fullstack:latest

# setup developer user
ENV UID=${UID:-1000}
ENV GID=${UID:-1000}
ENV USER=${USER:-developer}
RUN groupadd -g $GID $USER && \
  useradd -d /home/$USER -s /bin/bash -m $USER -l -u $UID -g $GID && \
  echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  usermod -aG docker $USER
USER $USER

# Highlight Branch in Bash
RUN echo "parse_git_branch() {" >> ~/.bashrc && \
  echo "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> ~/.bashrc && \
  echo "}" >> ~/.bashrc && \
  echo "export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ '" >> ~/.bashrc

# Update path
ENV PATH="$PATH:/home/developer/.local/bin"

# Create KUBECONFIG from contents of .kube
RUN echo "export KUBECONFIG=\$(find ~/.kube -maxdepth 1 -type f | tr '\n' ':')" >> ~/.bashrc

# Create kubectl alias
RUN echo "alias k='kubectl'" >> ~/.bashrc && \
  echo "alias python3='python3.11'" >> ~/.bashrc && \
  echo "alias python='python3.11'" >> ~/.bashrc