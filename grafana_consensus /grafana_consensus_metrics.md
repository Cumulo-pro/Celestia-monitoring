# Grafana consensus & validator metrics 

SYNC STATUS 

State Syncing 


## State Syncing

celestia_consensus_fast_syncing 

Celestia Fast Synchronisation Metric: A metric that indicates whether a node in the Celestia consensus system is performing fast synchronisation. When this metric has a value of 1, it means that the node is performing fast synchronisation. Conversely, a value of 0 indicates that the node is not currently performing fast synchronisation. Fast synchronisation is a process in which a node can quickly acquire a copy of the blockchain by downloading compressed states and blocks from full nodes in the network, which speeds up the process of catching up with the network. 

Value: Either NO SYNC (not block syncing) or SYNC (syncing) 

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/81812eaa-5c6e-4c78-b6a1-6e343c2d85ef)

## State Syncing 

celestia_consensus_state_syncing 

Celestia State Synchronisation Metric: A metric that indicates whether a node in the Celestia consensus system is performing state synchronisation. When this metric has a value of 1, it means that the node is performing state synchronisation. Conversely, a value of 0 indicates that the node is not currently performing state synchronisation. State synchronisation is a process in which a node updates its internal state to reflect the current state of the blockchain, which may include verification of smart contracts, pending transactions, among other things. 

Value: indicates whether a node is synchronising its state, FALSE is not currently performing state synchronisation, TRUE is performing state synchronisation. 

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/f0419725-6004-4a3c-a2a0-0d8676f04e2b)


