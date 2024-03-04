# Blobstream Orchestrator Monitor
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/fcbe9746-47a6-4975-a80f-6f7bc4d5c886)

## Introduction
Blobstream is a data availability solution designed for Ethereum that scales securely with the number of users. Formerly known as the Quantum Gravity Bridge (QGB), Blobstream relays commitments to Celestia's data root to an on-chain light client on Ethereum, enabling developers to integrate it into Layer 2 (L2) contracts. 
This allows Ethereum developers to build high-throughput L2s using advanced data availability mechanisms while still benefiting from the security guarantees of the Ethereum mainnet. 

+info: https://blog.celestia.org/introducing-blobstream/

## Description
The Blobstream Orchestrator Monitor is a set of tools designed to monitor the status of the Blobstream Orchestrator service. These tools allow collecting important information such as the latest signed commitments, detecting errors in the service logs, and sending alerts via Telegram in case of issues detection.

## Components
### Scripts
*[monitor_orchestrator_json.sh](https://raw.githubusercontent.com/Cumulo-pro/Celestia-monitoring/main/blobstream-monitor/script/monitor_orchestrator_json.sh)* is responsible for collecting vital information from the Blobstream Orchestrator and then crafting a JSON file encapsulating the gathered data. It primarily focuses on retrieving the latest signed commitments and conducting an error check within the service logs.
The resulting JSON file, orchestrator_test.json, will contain the following dataset:

<code>{
  "nonce": "3621",
  "begin_block": "=1309201",
  "end_block": "=1309601",
  "data_root_tuple_root": "=0x30708fe2aa5da760bce10d159de0c5753870d62d0ee563f19acb1e79cf8531c2",
  "data_utc": "2024-03-04 18:48:27",
  "has_errors": "false",
  "error_count": "0",
  "warning_count": "0",
  "error_logs": "\\n",
  "warning_logs": "\\n"
}</code>

This JSON structure encapsulates critical details such as the nonce, begin and end block numbers, data root tuple root, UTC timestamp, error status, counts of errors and warnings, as well as logs for errors and warnings, if any exist.

### Views
[view_orchestrator_json.php](https://raw.githubusercontent.com/Cumulo-pro/Celestia-monitoring/main/blobstream-monitor/views/view_orchestrator_json.php) This PHP file will be responsible for displaying the data in a web interface, making use of the variables extracted from the JSON.

You can see an example here:
[blobstream in Celestia Front-Chain](https://celestia.frontchain.cumulo.pro/blobstream.php)


### Services
[monitor_orchestrator.service](https://raw.githubusercontent.com/Cumulo-pro/Celestia-monitoring/main/blobstream-monitor/services/monitor_orchestrator.service) A systemd service that executes the monitor_orchestrator_json.sh script. This service ensures that the Orchestrator monitoring is performed regularly and automatically.

[monitor_orchestrator.timer](https://raw.githubusercontent.com/Cumulo-pro/Celestia-monitoring/main/blobstream-monitor/services/monitor_orchestrator.timer) A systemd timer that controls the periodic execution of the monitor_orchestrator.service service. It allows defining specific intervals for monitoring the Orchestrator.


