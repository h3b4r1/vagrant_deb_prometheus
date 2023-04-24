# Vagrant(Prometheus with Grafana) 
This is a basic prometheus build with node exporter and grafana for testing and education.

## Usage
- Set up a <a href="https://www.vagrantup.com/">Vagrant</a> environment with <a href="https://www.virtualbox.org/">virtualbox</a> as the virtualisation provider.
- Clone the repo using ```git clone <repo url>```
- cd to the repo directory and run ```vagrant up```
- Then to access the prometheus host CLI run ```vagrant ssh prometheus```
- Then to access the grafana host CLI run ```vagrant ssh grafana```
- The prometheus web UI can be accessed at http://localhost:9090
- The Grafana web UI can be accessed at http://localhost
