# Grafana consensus & validator metrics 

- [SYNC STATUS](#sync-status) 

- [State Syncing](#state-syncing)

- [Node Last Signed Height](https://github.com/Cumulo-pro/Celestia-monitoring/edit/main/grafana_consensus%20/grafana_consensus_metrics.md#node-last-signed-height)  

Node Voting Power 
Connected peers & P2P peers  
Height  Consensus Monitoring
Block time  
Consensus Height  
Block Size (bytes) 
Nº Transactions Committed



## SYNC STATUS 

*celestia_consensus_fast_syncing* 

Celestia Fast Synchronisation Metric: A metric that indicates whether a node in the Celestia consensus system is performing fast synchronisation. When this metric has a value of 1, it means that the node is performing fast synchronisation. Conversely, a value of 0 indicates that the node is not currently performing fast synchronisation. Fast synchronisation is a process in which a node can quickly acquire a copy of the blockchain by downloading compressed states and blocks from full nodes in the network, which speeds up the process of catching up with the network. 

Value: Either NO SYNC (not block syncing) or SYNC (syncing)


![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/81812eaa-5c6e-4c78-b6a1-6e343c2d85ef)

## State Syncing 

*celestia_consensus_state_syncing*

Celestia State Synchronisation Metric: A metric that indicates whether a node in the Celestia consensus system is performing state synchronisation. When this metric has a value of 1, it means that the node is performing state synchronisation. Conversely, a value of 0 indicates that the node is not currently performing state synchronisation. State synchronisation is a process in which a node updates its internal state to reflect the current state of the blockchain, which may include verification of smart contracts, pending transactions, among other things. 

Value: indicates whether a node is synchronising its state, FALSE is not currently performing state synchronisation, TRUE is performing state synchronisation. 

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/f0419725-6004-4a3c-a2a0-0d8676f04e2b)

## Node Last Signed Height  

*celestia_consensus_validator_last_signed_height*  

Indicates the most recent blockchain height at which a specific validator has signed a block in the Celestia consensus system. The numerical value represents this height. This metric is useful for monitoring the activity and status of validators on the network, as the signed height reflects the progress of consensus and validator participation in block production.  

Value: numeric value indicating the last height signed by the validator or No validator in case the node is not a validator.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/7c004aae-dc8a-4664-82cc-9fdcdd53cf5c)

## Node Voting Power  

*celestia_consensus_validator_power*  

Voting power of a specific validator in the Celestia consensus system.  

Value: numeric value in tokens representing voting power

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/0090c733-d04c-409c-b4cc-9759951339e9)

## Connected peers & P2P peers  

*celestia_p2p_peers*  

Number of nodes connected as peers in Celestia's peer-to-peer (P2P) network system. Peers in a P2P network are nodes that communicate directly with each other to share information and maintain network integrity. This metric provides information about the health and activity of the network, as a higher number of peers can indicate a more robust and distributed network.  

Value: numeric value indicating the nodes connected as peers  

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/52b14295-e199-41fb-abe8-1d65dc64092f)

## Height  Consensus Monitoring  

**celestia_consensus_start_height**  

Block height from which consensus-related metrics began to be recorded in the Celestia consensus system. This metric provides information about the reference point from which consensus related data is being collected and analysed in the network. The numerical value represents this starting height.  

Value: numeric value indicating the height from which metrics started in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/e7698318-f927-467b-9989-b2ddf9e8327b)


## Block time  

**celestia_consensus_block_time_seconds**  

Average time between the creation of consecutive blocks in the Celestia consensus system, expressed in seconds. This metric is critical for assessing the efficiency and health of the network, as a lower block time may indicate a faster and more responsive network, while a higher block time may indicate possible congestion problems or slowness in the consensus process.

Value: average block time in seconds in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/52f36a64-b33a-4b13-852c-932e6abb2337)

## Consensus Height  

**celestia_consensus_height**  

Current block height in the Celestia consensus system. This metric provides information on the progress of the blockchain in terms of confirmed blocks. It is a fundamental metric for monitoring the status and activity of the network, as it reflects where the consensus is in the blockchain at any given point in time.  

Value: numeric value representing the current height of the block in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/049da3ad-0c28-4bdf-bdf2-dfbb2858685f)

## Block Size (bytes)  

**celestia_consensus_block_size_bytes**  

Size of the last block in the Celestia consensus system, expressed in bytes. The block size is important for understanding the network's ability to handle transactions and data, as well as for assessing the efficiency of the consensus protocol in terms of block propagation and confirmation. 

Value: block size in bytes in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/f8741bf7-3622-4c4e-a58e-fe6ef07eeb91)

## Nº Transactions Committed  

**celestia_consensus_num_txs** 

Number of transactions included in the last block in the Celestia consensus system. This metric is crucial for understanding the activity and volume of transactions on the network at any given time. A higher number of transactions may indicate higher network activity, while a low or zero number may reflect periods of low network activity or congestion.

Value: Numeric value representing the number of transactions included in the last block

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/aa355eb9-73a3-44dd-80d4-12e2d49b9749)


