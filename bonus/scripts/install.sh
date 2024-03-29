#!/bin/bash

# install Helm
echo "[INFO]   Installing Helm"
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash


echo "[INFO]   Creating namespace for gitlab"
sudo kubectl create namespace gitlab

sudo helm repo add gitlab https://charts.gitlab.io/

sudo helm search repo gitlab

echo "[INFO]   Installing Gitlab, this may take a while..."
sudo helm install gitlab gitlab/gitlab   --set global.hosts.https="false" --set global.ingress.configureCertmanager="false" --set gitlab-runner.install="false" -n gitlab

echo "Gitlab installed ! Waiting for gitlab to be deployed"
sudo kubectl wait -n gitlab --for=condition=available deployment --all --timeout=-1s

echo "Installing ingress"
sudo kubectl apply -f ../confs/ingress.yaml -n gitlab

echo "[INFO]   Gitlab URL: http://localhost:8080"
echo "[INFO]   Gitlab username: root"
echo "[INFO]   Gitlab password: "

sudo kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo