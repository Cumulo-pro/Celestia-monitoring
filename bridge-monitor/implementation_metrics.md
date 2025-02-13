# Spicenet Custom Metrics Monitoring: Implementation and Configuration Guide

## Introduction  
Node Exporter is a Prometheus tool that collects operating system and server hardware metrics. It can also be used to expose custom metrics for any service or application. In this guide, we will walk you through setting up custom metrics monitoring for Spicenet using Node Exporter.  

## Prerequisites
1. Install `node_exporter` on your server.  
2. Ensure that you have a running Prometheus instance to collect and visualize the metrics.  

## Step 1: Prepare the Environment  
Create a directory to store the custom metrics scripts.  

```bash
sudo mkdir -p /usr/local/metrics
```

Download the metrics script `spicenet_metrics.sh`. This bash script will extract desired metrics from Spicenet and save them in a Prometheus-compatible format. It will then be picked up by Node Exporter for exposure.  

```bash
sudo wget https://raw.githubusercontent.com/your-repository/spicenet-monitoring/main/spicenet_metrics.sh -O /usr/local/metrics/spicenet_metrics.sh
```

## Step 2: Set up Node Exporter Service  
Edit the Node Exporter service file to enable the textfile collector for custom metrics. This will allow Node Exporter to collect metrics from the directory where our custom metrics are stored.  

Open `/etc/systemd/system/node_exporter.service` in an editor and modify the `ExecStart` line:  

```bash
sudo sed -i 's|ExecStart=/usr/local/bin/node_exporter.*|ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/usr/local/metrics|' /etc/systemd/system/node_exporter.service
```

Reload the systemd daemon to recognize the changes:  

```bash
sudo systemctl daemon-reload
```

Restart Node Exporter to apply the configuration changes:  

```bash
sudo systemctl restart node_exporter
```

Ensure that Node Exporter has the necessary permissions to read the metrics files:  

```bash
sudo chown -R node_exporter:node_exporter /usr/local/metrics
sudo chmod -R 755 /usr/local/metrics
```

## Step 3: Service and Timer Configuration  
To periodically update the custom metrics, we need to create a systemd service and timer.  

Create the service file /etc/systemd/system/update_spicenet_metrics.service:  

```bash
sudo tee /etc/systemd/system/update_spicenet_metrics.service > /dev/null << EOF
[Unit]
Description=Spicenet metrics update
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/metrics/spicenet_metrics.sh

[Install]
WantedBy=multi-user.target
EOF
```

Create the timer file /etc/systemd/system/update_spicenet_metrics.timer:  

```bash
sudo tee /etc/systemd/system/update_spicenet_metrics.timer > /dev/null << EOF
[Unit]
Description=Timer for Spicenet metrics update

[Timer]
OnUnitActiveSec=30s
Persistent=true

[Install]
WantedBy=timers.target
EOF
```

Enable and start the service and timer:  

```bash
sudo systemctl daemon-reload
sudo systemctl enable update_spicenet_metrics.service
sudo systemctl start update_spicenet_metrics.service
sudo systemctl enable --now update_spicenet_metrics.timer
```
