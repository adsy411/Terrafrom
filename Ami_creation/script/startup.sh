#!/usr/bin/env bash


##Swap off
# The swap should be turned off
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

##Installing required packages
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

##Adding Fingerprintds && repositories to achieve our goal
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb
https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y
sudo apt-get install -y docker-ce kubelet kubeadm kubectl
sudo systemctl enable docker.service
sudo apt-mark hold kubelet kubeadm kubectl