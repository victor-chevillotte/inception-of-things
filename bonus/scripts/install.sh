# install Helm
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# create namespace for gitlab
sudo kubectl create namespace gitlab

echo "Adding Gitlab Helm repository..."
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update

echo "Installing Gitlab, this may take a while..."
echo "to follow the deployment : sudo kubectl get all -n gitlab or sudo helm status gitlab -n gitlab"
sudo helm upgrade --install gitlab gitlab/gitlab \
  -n gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain=10.11.1.253.nip.io \
  --set global.hosts.externalIP=10.11.1.253 \
  --set global.edition=ce \
  --timeout 600s

echo "Waiting for pods to be ready"
sudo kubectl wait --for=condition=available deployments --all -n gitlab --timeout=1200s

echo "Credentials :"
echo "localhost:8181"
echo "root"
sudo kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 --decode ; echo

echo "Gitlab is deployed !"
sudo kubectl port-forward service/gitlab-webservice-default 8181:8181 -n gitlab --address 0.0.0.0 &