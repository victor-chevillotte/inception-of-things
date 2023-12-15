## Inception Of Things

__42 School Project__  

### Goals

- Deploy k3s Clusters using Vagrant
- Deploy Applications in k3s
- Deploy a kubernetes cluster with k3d
- Run GitOps workflows with ArgoCD
- Deploy Gitlab with Helm on kubernetes

**The project must be ran in a virtual machine, therefore an installation script is provided**  


### Master Virtual machine Specs

Virtual machine must have this config :
OS : ubuntu-22.04.3-desktop-amd64
https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-desktop-amd64.isousername 

- 30 Go de stockage
- 10 Go de ram
- 12 vCPU
- VT-x Enabled (Virtualbox>settings>system>processor)

set all username passzord etc as iot

download project from github web (downloads zip)
```
bash main vm/install_in_vm.sh
```

---
### P1

- Deploy a k3s cluster with a Server Node and a Worker Node using Vagrant 
- Test deployment
```
sudo kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
sudo kubectl get pods -A
sudo kubectl describe pod <POD_NAME>
```

---
### P2

- Deploy a k3s cluster with only a Server Node
- Run 3 apps as follows :
    - app1 : 1 Replica
    - app2 : 3 Replica
    - app3 : 1 Replica
- An ingress is deployed
- Test deployment with :
```
curl 192.168.56.110
curl -H "Host: app1.com" 192.168.56.110
curl -H "Host: app3.com" 192.168.56.110
```

---
### P3

- Deploys a k3d cluster 
- Deploys ArgoCD 
- Deploys an app with ArgoCD : We used our repository https://github.com/victor-chevillotte/iot-app.git


---
### Bonus

- Deploys Gitlab on k3d
- Deploys a repo hosted on local Gitlab with ArgoCD
