# Implementation and Configuration of Custom Metrics Monitoring

## Introduction

**Node Exporter** is a Prometheus tool that collects operating system and server hardware metrics. However, it can also be used to expose custom metrics.

Prerequisites:
- Install node_exporter on your server

## Step 1: Prepare the environment

Create a **metrics** directory to store metrics scripts.

```bash
cd /usr/local/
sudo mkdir metrics
```
