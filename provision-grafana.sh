# Install the grafana application
apt-get -y install adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.4.7_amd64.deb
apt -y install ./grafana_9.4.7_amd64.deb

# Enable and start grafana
systemctl enable --now grafana-server

# Configure Grafana for use with Prometheus
