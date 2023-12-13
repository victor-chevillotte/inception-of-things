#!/bin/bash

# Create cluster
sudo k3d cluster create iot-cluster  -p 8443:443@loadbalancer -p 8888:8888@loadbalancer 

# Install Argo CD
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sudo kubectl rollout status deployment argocd-server -n argocd
sudo kubectl rollout status deployment argocd-redis -n argocd
sudo kubectl rollout status deployment argocd-repo -n argocd
sudo kubectl rollout status deployment argocd-dex-server -n argocd

#sudo kubectl wait --for=condition=Ready --timeout=300s -n argocd --all pod

# Create Argo project
sudo kubectl create namespace dev
sudo kubectl apply -f ../confs/project.yaml -n argocd
sudo kubectl apply -f ../confs/application.yaml -n argocd

sudo kubectl wait --for=condition=Ready --timeout=300s -n dev --all pod

# Get Argo CD password
echo "Argo CD credentials :"
echo "admin"
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" 2> /dev/null | base64 -d
echo
echo

# Access Argo CD
sudo kubectl port-forward service/argocd-server -n argocd 8090:443 --address 0.0.0.0 & #& to run in background

# Access Argo CD UI
echo "Argo CD UI :"
echo "https://localhost:8090"
