Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
    server.vm.hostname = "gitlab"
    server.vm.box = "generic/ubuntu2004"

    server.vm.provider :libvirt do |domain|
      domain.cpus = 8
      domain.memory = 6144
    end

    server.vm.network :public_network, mode: "bridge", type: "bridge", dev: "br0",
      mac: "92:3e:78:0e:c3:15"

    config.vm.synced_folder "./", "/vagrant", type: "nfs"

    server.vm.provision "shell", path: "./provision.sh"
    server.vm.provision "shell", path: "./provision-int.sh"
  end

end
