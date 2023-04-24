Vagrant.configure("2") do |config|
    config.vm.define "prometheus" do |prometheus|
        prometheus.vm.box = "debian/bullseye64"
        prometheus.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
            vb.cpus = 2
      end
      prometheus.vm.hostname = "prometheus"
      prometheus.vm.network "forward_port", guest: 9090, host: 9090
      prometheus.vm.network "private_network", ip: "10.0.0.16", netmask:"255.255.255.0"
      prometheus.vm.provision "shell", path: "./debian11-setup.sh"
      prometheus.vm.provision "shell", path: "./provision-prometheus.sh"
    end
    config.vm.define "grafana" do |grafana|
        grafana.vm.box = "debian/bullseye64"
        grafana.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
            vb.cpus = 2
      end
      grafana.vm.hostname = "grafana"
      grafana.vm.network "forward_port", guest: 3000, host: 80
      grafana.vm.network "private_network", ip: "10.0.0.17", netmask:"255.255.255.0"
      grafana.vm.provision "shell", path: "./debian11-setup.sh"
      grafana.vm.provision "shell", path: "./provision-grafana.sh"
    end
end