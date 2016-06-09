# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.boot_timeout = 400
  config.vm.synced_folder "shared", "/tmp/shared"

  config.vm.define "master" do |master|
  	master.vm.hostname = "ammaster.qac.local"
	master.vm.box = "Ubuntu_15.10_x86.64"
	master.vm.network "public_network", ip: "192.168.99.101"
	master.vm.provision "shell", path: "master.sh"

	master.vm.provider "virtualbox" do |mastervm|
		mastervm.gui = true
		mastervm.name = "Master"
		mastervm.memory = 2048
		mastervm.cpus = 2
	end
   end

   config.vm.define "agent" do |agent|
   	agent.vm.hostname = "amagent1.qac.local"
	agent.vm.box = "Ubuntu_15.10_x86.64"
	agent.vm.network "public_network", ip: "192.168.99.102"
	agent.vm.provision "shell", path: "agent.sh"

	agent.vm.provider "virtualbox" do |agent1vm|
		agent1vm.gui = true
		agent1vm.name = "Agent 1"
		agent1vm.memory = 2048
		agent1vm.cpus = 2
	end
   end

end
