# Scraping of Bridge Node Metrics in Prometheus

## Introduction 

In this project, we will implement a system for monitoring custom metrics for a bridge node using Prometheus and Node Exporter. Node Exporter is a powerful tool that collects operating system and hardware metrics from servers and can also be extended to expose custom metrics. Through this project, you will learn how to configure Node Exporter to collect and expose specific metrics from the bridge node, and how to automate this process using scripts and systemd services. This approach will provide you with detailed insights into the performance and status of the bridge node, facilitating efficient monitoring and maintenance of the system.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/bf295683-7258-48eb-a341-89aee27ea84a)

## Features

### Non-Intrusive Method

The implementation of these metrics does not require any modifications to the bridge node configuration. This ensures that the bridge node continues to operate optimally without interruptions or changes to its original setup.

### Exclusive Use of Node Exporter

No additional applications or services are needed apart from **Node Exporter**, which should already be implemented to monitor server resources. This simplifies the setup and reduces administrative overhead.

### No Impact on Server Resources

The monitoring process does not alter the server resources dedicated to the bridge node. A simple script is used, which runs periodically via systemd and timers, ensuring that the server's performance is not affected.

### Simple and Quick Implementation

The implementation is extremely simple and quick. It only requires downloading a script and configuring systemd, which can be completed in a few minutes. This allows system administrators to set up metric monitoring without complications and with minimal time investment.

### Automated and Periodic Updates

The system is designed to update the metrics periodically and automatically using systemd services and timers. This ensures that up-to-date data is always available without continuous manual intervention.

With these features, this project provides an efficient and effective solution for monitoring custom metrics of the bridge node, leveraging the capabilities of Prometheus and Node Exporter to enhance the monitoring and maintenance of your infrastructure.

## Available Resources

Grafana consensus & validator metrics

This document details the specific metrics available in Grafana for Celestia's Bridge nodes. It includes descriptions and explanations of various key metrics, such as sync status, validator voting power, mempool size, and more.


