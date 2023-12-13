echo "Creating cluster"
sudo k3d cluster create iot-cluster  -p 8443:443@loadbalancer -p 8888:8888@loadbalancer 
echo "Cluster created, waiting..."

sleep 5

echo "Creating namespaces"
sudo kubectl create namespace argocd
sudo kubectl create namespace dev
echo "Namespaces created"

echo "Installing argocd"
sudo kubectl apply -n argocd -f ../confs/install.yaml
echo "Argo CD installed, waiting..."

echo "Waiting the pods to be ready"
sudo kubectl wait -n argocd --for=condition=Ready pods --all
echo "Pods ready, waiting..."

echo "Installing ingress"
sudo kubectl apply -f ../confs/ingress.yaml -n argocd
echo "Installed ingress, waiting..."


echo "Installing project to argocd"
sudo kubectl apply -f ../confs/project.yaml -n argocd
echo "Installed project to argocd"

echo "Installing application to argocd"
sudo kubectl apply -f ../confs/application.yaml -n argocd
echo "application installed  to argocd"

echo "Everything is installed!"

echo "Argo CD credentials :"
echo "admin"
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" 2> /dev/null | base64 -d

echo
echo "Argo CD UI :"
echo "http://localhost:8080"