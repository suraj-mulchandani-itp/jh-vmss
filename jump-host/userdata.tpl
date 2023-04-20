#!/bin/bash

set -euo pipefail

sudo apt-get update -y
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg snapd git

# Install kubectl
echo "[INFO] Installing kubectl"

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
 curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    sudo chmod +x kubectl && \
      sudo mv ./kubectl /usr/local/bin

# Install helm
echo "[INFO] Installing helm"

wget https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz && \
  tar xvf helm-v3.9.3-linux-amd64.tar.gz && \
     sudo mv linux-amd64/helm /usr/local/bin

# Install az-cli
echo "[INFO] Installing az-cli"

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install kubelogin
echo "[INFO] Installing az-cli"

az aks install-cli

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo chmod 666 /var/run/docker.sock

# Install Docker Compose

sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose