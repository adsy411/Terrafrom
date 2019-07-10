#!/usr/bin/env bash
kubeadm init
sed -i '1s/.*/k8s-master/' /etc/hostname