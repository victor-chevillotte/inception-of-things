## Inception Of Things

__42 School Project__  

### Goals

- Deploy k3s Clusters using Vagrant
- Deploy Applications in k3s
- Deploy a kubernetes cluster with k3d
- Run GitOps workflows with ArgoCD
- Deploy Gitlab with Helm on kubernetes

### Master Virtual machine Specs

Virtual machine must have this config :
OS : ubuntu-22.04.3-desktop-amd64
https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-desktop-amd64.isousername 

- 30 go de stockage
- 7.5 go de ram
- 12 vCPU
- VT-x Enabled (Virtualbox>settings>system>processor)

set all username passzord etc as iot

download project from github web (downloads zip)
```
bash main vm/install_in_vm.sh
```
todo var env