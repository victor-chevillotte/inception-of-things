#!/bin/bash

sudo k3d cluster create iot-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2 --wait

sudo kubectl create namespace argocd
sudo kubectl create namespace dev
