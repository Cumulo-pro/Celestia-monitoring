# Implementation and Configuration of Custom Metrics Monitoring

## Introduction

**Node Exporter** is a Prometheus tool that collects operating system and server hardware metrics. However, it can also be used to expose custom metrics.

Prerequisites:
- Install node_exporter on your server

## Step 1: Prepare the environment

Create a **metrics** directory to store metrics scripts.

```bash
sudo mkdir -p /usr/local/metrics
```

Download the metrics script **[get_bridge_height.sh](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/get_bridge_height.sh)**

This is a bash script that extracts the desired metrics from the bridge node and sends them to Prometheus. The script is not intrusive it just executes a series of CLI commands and sends the metrics to node_exporter_metrics.prom file, these metrics will be picked up by node_exporter to expose them in Prometheus. 

```bash
sudo wget https://raw.githubusercontent.com/Cumulo-pro/Celestia-monitoring/main/bridge-monitor/get_bridge_height.sh -O /usr/local/metrics/get_bridge_height.sh
```

Provides the necessary permissions to the script
```bash
sudo chmod +x /usr/local/metrics/get_bridge_height.sh
```

## Step 2: Setting up the Node Exporter service

```bash
sudo sed -i 's|ExecStart=/usr/local/bin/node_exporter.*|ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/usr/local/metrics|' /etc/systemd/system/node_exporter.service
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/efa26b98-62e5-4758-882f-2cbf85df7abf)


