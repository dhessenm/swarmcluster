# -*- mode: ruby -*-
# vi: set ft=ruby :

# Defaults, variables
# -------------------
MANAGER_MEMORY_SIZE = 1024
NODE_MEMORY_SIZE = 2048

# Configure
# ---------
Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "vmware_fusion" do |vmware, override|
    override.vm.box = "dh/ubuntu-14.04.2"
  end

  config.vm.provider "virtualbox" do |v, override|
    v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end
  
  # global bootstrap
  # config.vm.provision :shell, path: "bootstrap.sh", env: {"PROXY" => "http://wwwproxy.bahn-net.db.de:8080"}
  config.vm.provision :shell, path: "bootstrap.sh" 

  # BEGIN swarm-manager old
  # -----------------------
  # config.vm.define "swarm-manager" do |sm|
    # sm.vm.hostname = "swarm-manager"
    # sm.vm.provision :shell, path: "bootstrap_ansible.sh"
    # sm.vm.network "private_network", ip: "192.168.165.211"
    # sm.vm.provider "virtualbox" do |v|
      # v.memory = MANAGER_MEMORY_SIZE
      # v.cpus = 1
      # v.gui = false
    # end
    # sm.vm.provider "vmware_fusion" do |vmware|
      # vmware.vmx["memsize"] = MANAGER_MEMORY_SIZE
      # vmware.vmx["numvcpus"] = 1
      # vmware.gui = false
    # end
  # end
  # END swarm-manager old
  # ---------------------


  # BEGIN swarm-manager new
  # -----------------------
  (1..1).each do |i|
    config.vm.define "swarm-manager#{i}" do |sm|
      sm.vm.hostname = "swarm-manager#{i}"

      if sm.vm.hostname == "swarm-manager1"
        sm.vm.provision :shell, path: "bootstrap_ansible.sh"
      end

      sm.vm.network "private_network", ip: "192.168.165.21#{i}"
      sm.vm.network :forwarded_port, guest: 8080, host: "808#{i}"
      sm.vm.provider "virtualbox" do |v|
        v.memory = MANAGER_MEMORY_SIZE
        v.cpus = 1
        v.gui = false
      end
      sm.vm.provider "vmware_fusion" do |vmware|
        vmware.vmx["memsize"] = MANAGER_MEMORY_SIZE
        vmware.vmx["numvcpus"] = 1
        vmware.gui = false
      end
    end
  end
  # END swarm-manager new
  # ---------------------

  # BEGIN swarm-worker
  # -----------------
  (1..2).each do |i|
    config.vm.define "swarm-worker#{i}" do |sn|
      sn.vm.hostname = "swarm-worker#{i}"
      sn.vm.network "private_network", ip: "192.168.165.22#{i}"
      sn.vm.network :forwarded_port, guest: 8080, host: "908#{i}"
      sn.vm.provider "virtualbox" do |v|
        v.memory = NODE_MEMORY_SIZE
        v.cpus = 1
        v.gui = false
      end
      sn.vm.provider "vmware_fusion" do |vmware|
        vmware.vmx["memsize"] = NODE_MEMORY_SIZE
        vmware.vmx["numvcpus"] = 1
        vmware.gui = false
      end
    end
  end
  # END swarm-worker
  # ---------------

end

