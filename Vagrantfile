#  Commands :
#  vagrant up
#
#  vagrant ssh vchevillS
#  sudo k3s kubectl get nodes -o wide
#  
#  ifconfig eth1
#  ip addr show eth1
#  
#  vagrant destroy -f
#

Vagrant.configure("2") do |config|

	config.vm.define "vchevillS" do |vchevillS|
	  vchevillS.vm.box = "debian/bullseye64"
	  vchevillS.vm.hostname = "vchevillS"
	  vchevillS.vm.network "private_network", ip: "192.168.56.110", bridge: "eth1"
	  vchevillS.vm.provider "virtualbox" do |vb|
		vb.name = "vchevillS"
		vb.cpus = 2
		vb.memory = 1024
	  end
	  vchevillS.vm.provision :shell, inline: <<-SHELL
		sudo install_in_vm.sh
	  SHELL
	end
end