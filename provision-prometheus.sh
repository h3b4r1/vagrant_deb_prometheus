# Install Prometheus
apt-get update
apt-get install gosu

useradd -M prometheus
usermod -L prometheus

mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
tar -xvf prometheus-2.43.0.linux-amd64.tar.gz

cp prometheus-2.43.0.linux-amd64/prometheus /usr/local/bin/
cp prometheus-2.43.0.linux-amd64/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -r prometheus-2.43.0.linux-amd64/prometheus.yml /etc/prometheus/
cp -r prometheus-2.43.0.linux-amd64/consoles /etc/prometheus
cp -r prometheus-2.43.0.linux-amd64/console_libraries /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries

cat > /etc/prometheus/prometheus.yml<<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'local_node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100']
  - job_name: 'grafana_node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['10.0.0.17:9100']
  - job_name: 'grafana_app_metrics'
    scrape_interval: 5s
    static_configs:
      - targets: ['10.0.0.17:3000']
EOF

cat > /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Restart=on-failure
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/data \
  --storage.tsdb.retention.time=30d

[Install]
WantedBy=multi-user.target
EOF

# Install Node Exporter
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

systemctl daemon-reload
systemctl enable --now prometheus.service
systemctl enable --now node_exporter.service
