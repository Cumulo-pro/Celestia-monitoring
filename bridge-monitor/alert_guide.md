# Celestia Bridge Node Alert Configuration Guide

## Introduction

This guide explains how to set up alert rules for a Celestia Bridge node using Prometheus. It configures these alerts to monitor important metrics such as node synchronization, peer connectivity, and network errors. It also covers how to set up notifications in Grafana or other systems like Slack or email.

### Explanation of the Alert Rules:

- **BridgeNodeOutOfSync**: Triggers when the local block height (`bridge_height`) is more than 100 blocks behind the RPC-reported height (`current_block_rpc`) for over 5 minutes.
  
- **HighTimeoutErrors**: Triggers if the number of network connectivity timeout errors (`timeout_errors`) increases by more than 5 in the last 10 minutes.
  
- **HighConnectionsClosed**: Triggers if more than 5 remote host connection closures (`connections_closed`) occur in a 10-minute window.
  
- **LowPeerCount**: Triggers if the node has fewer than 3 full peers (`full_peer_count`) for more than 5 minutes.
  
- **FrequentWantlistOverflow**: Detects frequent wantlist overflow events if the overflow size (`wantlist_overflow_size`) increases more than 50 times within 10 minutes.
  
- **NodeUptimeCheck**: Checks if the node has been recently restarted. If the node's uptime is less than 600 seconds (10 minutes), an informational alert is triggered.

## Instructions

### Step 1: Set Up Prometheus and Metrics Collection

Ensure that:
- Prometheus is already installed and running.
- Prometheus is scraping the metrics from the Celestia Bridge node using the metrics script.
  
If Prometheus is not scraping the metrics from your Celestia Bridge node, modify your `prometheus.yml` configuration file to include the job configuration for scraping from the appropriate endpoint.

### Step 2: Create the Alert Rules

You can find the `celestia_bridge_alerts.yml` alert rules on GitHub by clicking the button below:

[![Celestia Bridge Alerts](https://img.shields.io/badge/Bridge%20Alerts-GitHub-blue?style=for-the-badge)](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/bridge-monitor/celestia_bridge_alerts.yml)

### Step 3: Edit the Prometheus Configuration

1. **Edit your Prometheus configuration file** (`prometheus.yml`):

   Add the path to the alert rules file in the `rule_files` section of the Prometheus config file. Here’s an example of what the modified `prometheus.yml` will look like:

   ```yaml
   rule_files:
     - "/etc/prometheus/rules/celestia_bridge_alerts.yml"

## Restart Prometheus

After adding the alert rules to Prometheus, restart the Prometheus service for the changes to take effect:

```bash
sudo systemctl restart prometheus
```

## Step 4: Set Up Notification Channels in Grafana

Now that Prometheus has the alert rules, you need to set up notification channels in Grafana to handle the alerts.

1. **Log in to Grafana**.
2. **Navigate to Configuration**:
   - Click on the ⚙️ icon on the sidebar and select **Notification channels**.
3. **Add a New Notification Channel**:
   - Click **Add channel** and configure a notification channel (e.g., email, Slack, etc.).
   - Fill in the required details for your preferred notification method (e.g., webhook URL for Slack, email configuration).
   - Test the notification to ensure it's working.
   - Save the notification channel.

---

## Step 5: Integrate Prometheus Alerts in Grafana

1. **Add Prometheus as a Data Source in Grafana**:
   - Go to **Configuration > Data Sources > Add Data Source**.
   - Select **Prometheus** and add your Prometheus server's URL (e.g., `http://localhost:9090`).
   - Test the connection to ensure it's working.

2. **Set Up Grafana Alerts (Optional)**:
   - You can also create Grafana alerts based on the same metrics if you prefer using Grafana's alerting mechanism.
   - Create a panel for the metric, add a threshold, and configure the alert conditions directly in Grafana.  

![image](https://github.com/user-attachments/assets/dfae38b4-843d-4b99-ad12-fcf03f15eddd)

