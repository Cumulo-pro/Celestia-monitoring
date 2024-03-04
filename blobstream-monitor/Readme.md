# Blobstream Orchestrator Monitor
## Introduction
Blobstream is a data availability solution designed for Ethereum that scales securely with the number of users. Formerly known as the Quantum Gravity Bridge (QGB), Blobstream relays commitments to Celestia's data root to an on-chain light client on Ethereum, enabling developers to integrate it into Layer 2 (L2) contracts. 
This allows Ethereum developers to build high-throughput L2s using advanced data availability mechanisms while still benefiting from the security guarantees of the Ethereum mainnet. 

+info: https://blog.celestia.org/introducing-blobstream/

## Description
The Blobstream Orchestrator Monitor is a set of tools designed to monitor the status of the Blobstream Orchestrator service. These tools allow collecting important information such as the latest signed commitments, detecting errors in the service logs, and sending alerts via Telegram in case of issues detection.

## Components
### Scripts
*monitor_orchestrator_json.sh*
This Bash script is responsible for gathering information from the Blobstream Orchestrator and generating a JSON file with the obtained data. It extracts the latest signed commitments and checks for errors in the service logs.
