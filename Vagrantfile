# -*- mode: ruby -*-

# vi: set ft=ruby :

boxes = [
    {
        :name => "master1",
        :mem => "2048",
        :cpu => "1"
    },
    {
        :name => "node1",
        :mem => "2048",
        :cpu => "1"
    },
    {
        :name => "node2",
        :mem => "2048",
        :cpu => "1"
    }
]

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  # load vagrant-cachier if available, reduce some data traffic and time too ...
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :apt
    config.cache.enable :gem
  end

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "dh/ubuntu-14.04.2"
  end

  # Turn off shared folders
  # config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]

      config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end

      # config.vm.network :private_network, ip: opts[:eth1]
      config.vm.provision :ansible do |ansible|
         ansible.verbose = "v"
         ansible.playbook = "provision/swarmcluster.yml"
      end
    end
  end
end

