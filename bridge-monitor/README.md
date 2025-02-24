![Portada-03](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/e673b4a6-28ec-4488-9299-7ba238306145)

## Introduction 

System for monitoring custom metrics for a bridge node using Prometheus and Node Exporter. Node Exporter is a powerful tool that collects operating system and hardware metrics from servers and can also be extended to expose custom metrics. Through this project, you will learn how to configure Node Exporter to collect and expose specific metrics from the bridge node, and how to automate this process using scripts and systemd services. This approach will provide you with detailed insights into the performance and status of the bridge node, facilitating efficient monitoring and maintenance of the system.

## Available Resources

- **[Install Bridge metrics](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/install_bridge_metrics.md)**

  Implementation and Configuration of Custom Metrics Monitoring

- **[Bridge metrics FAQ](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/bridge_metrics.md)**

  This document details the specific metrics available in Grafana for Celestia's Bridge nodes. It includes descriptions and explanations of various key metrics, such as sync status, validator voting power, mempool size, and more.

- **[Grafana Dashboard JSON Configuration File](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/Celestia%20Bridge%20Node.json)**

  This resource provides a JSON configuration file for a Grafana dashboard. The file includes all the necessary definitions and settings to visualize bridge node metrics in Grafana, making it easy to create informative panels and interactive graphs for real-time monitoring.

- **[Grafana Dashboard: Celestia Bridge Node](https://grafana.com/grafana/dashboards/22070-celestia-bridge-node-v3/)**

  System for monitoring custom metrics for a bridge node using Prometheus and Node Exporter. Node Exporter is a powerful tool that collects operating system and hardware metrics from servers and can also be extended to expose custom metrics.

- **[info_bridge.sh](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/info_bridge.sh)**

  Bash script designed to collect various metrics related to the celestia-bridge service and save this data in a metrics file in Prometheus format.

- **[Celestia Bridge Node Alert Configuration Guide](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/alert_guide.md)**

  This guide explains how to set up alert rules for a Celestia Bridge node using Prometheus.

- **[celestia_bridge_alerts.yml](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/celestia_bridge_alerts.yml)**

  Alert configuration file

- **[CLI queries to a Celestia bridge node](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/bridge-queries.md)**

  Set of commands to perform different queries to a Celestia bridge node.

## Features

### Non-Intrusive Method

The implementation of these metrics does not require any modifications to the bridge node configuration. This ensures that the bridge node continues to operate optimally without interruptions or changes to its original setup.

### Exclusive Use of Node Exporter

No additional applications or services are needed apart from **Node Exporter**, which should already be implemented to monitor server resources. This simplifies the setup and reduces administrative overhead.

### No Impact on Server Resources

The monitoring process does not alter the server resources dedicated to the bridge node. A simple script is used, which runs periodically via systemd and timers, ensuring that the server's performance is not affected.
  - Memory: 4.8 MB is low and typical for scripts of this type.
  - CPU: 1.202 seconds is an acceptable CPU usage for a periodic execution every 6 seconds.

### Simple and Quick Implementation

The implementation is extremely simple and quick. It only requires downloading a script and configuring systemd, which can be completed in a few minutes. This allows system administrators to set up metric monitoring without complications and with minimal time investment.

### Automated and Periodic Updates

The system is designed to update the metrics periodically and automatically using systemd services and timers. This ensures that up-to-date data is always available without continuous manual intervention.

With these features, this project provides an efficient and effective solution for monitoring custom metrics of the bridge node, leveraging the capabilities of Prometheus and Node Exporter to enhance the monitoring and maintenance of your infrastructure.

![image](https://github.com/user-attachments/assets/7e44f352-9156-4b86-b118-3142504dff10)


