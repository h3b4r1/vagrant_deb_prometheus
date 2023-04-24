# Install the grafana application
apt-get -y install adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.4.7_amd64.deb
apt -y install ./grafana_9.4.7_amd64.deb


# Install Node Exporter
useradd -M prometheus
usermod -L prometheus

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar -xvf node_exporter-1.5.0.linux-amd64.tar.gz

cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/node_exporter

cat > /etc/systemd/system/node_exporter.service<<EOF
[Unit]
Description=Prometheus Node Exporter
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Restart=on-failure
ExecStart=/usr/local/bin/node_exporter \
    --collector.loadavg \
    --collector.meminfo \
    --collector.filesystem

[Install]
WantedBy=multi-user.target
EOF

# Enable and start services
systemctl daemon-reload
systemctl enable --now grafana-server
systemctl enable --now node_exporter.service
