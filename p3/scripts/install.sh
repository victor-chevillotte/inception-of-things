#!/bin/bash

# Create cluster
sudo k3d cluster create iot-cluster -p 8090:80@loadbalancer -p 8443:443@loadbalancer
sleep 5

# Install Argo CD
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl wait --for=condition=Ready --timeout=300s -n argocd --all pod

echo "installing ingress"
export KUBECONFIG="$(sudo k3d kubeconfig write iot-cluster)"
sudo kubectl create deployment nginx --image=nginx -n argocd
sudo kubectl create service clusterip nginx --tcp=80:80 -n argocd
sudo kubectl apply -f ../confs/ingress.yaml -n argocd
echo "installed ingress, waiting..."
sleep 3

# Create Argo project
sudo kubectl create namespace dev
sudo kubectl apply -f ../confs/project.yaml -n argocd
sudo kubectl apply -f ../confs/application.yaml -n dev

sudo kubectl wait --for=condition=Ready --timeout=300s -n dev --all pod
#sudo kubectl port-forward service/vchevill-playground -n dev 8888:8888 --address 0.0.0.0 & #& to run in background

# Get Argo CD password
echo "Argo CD credentials :"
echo "admin"
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" 2> /dev/null | base64 -d
echo
echo

# Access Argo CD
#sudo kubectl port-forward service/argocd-server -n argocd 8090:443 --address 0.0.0.0 & #& to run in background

# Access Argo CD UI
echo "Argo CD UI :"
echo "https://localhost:8090"


sudo kubectl get ingress -n argocd