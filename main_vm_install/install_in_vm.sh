
sudo apt update
sudo apt upgrade -y

sudo apt install curl -y
sudo apt install vim -y
sudo apt install git -y

sudo apt install virtualbox -y
sudo virtualbox --version

sudo wget https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb
sudo chmod +x vagrant_2.2.19_x86_64.deb
sudo apt install ./vagrant_2.2.19_x86_64.deb
sudo rm vagrant_2.2.19_x86_64.deb
sudo vagrant --version

sudo apt install docker.io -y
sudo docker --version

curl -LO "https://dl.k8s.io/v1.26.0/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash