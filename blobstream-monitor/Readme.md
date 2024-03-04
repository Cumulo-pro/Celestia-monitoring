# Blobstream Orchestrator Monitor
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

