# Grafana consensus & validator metrics 

- [Sync Status](#sync-status)
- [State Syncing](#state-syncing)
- [Node Last Signed Height](#node-last-signed-height)
- [Node Voting Power](#node-voting-power)
- [Connected Peers & P2P Peers](#connected-peers--p2p-peers)
- [Height Consensus Monitoring](#height-consensus-monitoring)
- [Block Time](#block-time)
- [Consensus Height](#consensus-height)
- [Block Size (bytes)](#block-size-bytes)
- [Nº Transactions Committed](#nº-transactions-committed)
- [Total Txs](#total-txs)
- [Missing Validators Power](#missing-validators-power)
- [Nº Validators Missing Blocks](#nº-validators-missing-blocks)
- [Total Bonded Tokens](#total-bonded-tokens)
- [Consensus Validators](#consensus-validators)
- [Consensus Step Duration](#consensus-step-duration)
- [Block Processing Time](#block-processing-time)
- [Interval between Consensus Blocks](#interval-between-consensus-blocks)
- [Number of Block Parts Received](#number-of-block-parts-received)
- [Block Interval Seconds Sum](#block-interval-seconds-sum)
- [Block Interval Seconds Count](#block-interval-seconds-count)
- [Mempool Size](#mempool-size)
- [Duplicate Transactions in Mempool](#duplicate-transactions-in-mempool)
- [Mempool tx Size Bytes Sum](#mempool-tx-size-bytes-sum)
- [Mempool Size Bytes](#mempool-size-bytes)
- [Txs Evicted Mempool](#txs-evicted-mempool)
- [Txs Failed Mempool](#txs-failed-mempool)
- [Process CPU Seconds Total](#process-cpu-seconds-total)
- [Current Process Virtual Memory Usage](#current-process-virtual-memory-usage)
- [Current Process Resident Memory Usage](#current-process-resident-memory-usage)
- [Duration of Garbage Collection Pauses in Go](#duration-of-garbage-collection-pauses-in-go)
_________________________________________________________________________

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

## Total txs  

**celestia_consensus_total_txs** 

Total number of transactions processed in the Celestia consensus system since inception. This metric is essential to understand the cumulative activity of the network and the total volume of transactions completed. Tracking the total number of transactions can provide insight into the growth and adoption of the network over time.

Value: a numeric value representing the total number of transactions processed so far in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/0d83c2b8-bc2e-44d9-9504-261df31d5d96)

## Missing Validators Power  

**celestia_consensus_missing_validators_power** 

Total power of missing validators in the Celestia consensus system. Missing validators refer to those who are not active or are not participating in the consensus process at a given time. This metric can provide information about the health and integrity of the network, as a significant missing validator power could indicate problems with the participation or availability of validator nodes in the network. 

Value: numeric value representing the total power of the missing validators in the Celestia consensus system. A low or zero value is desirable, as it suggests active and healthy participation of validators in the consensus process.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/6102d610-0d26-4df8-b755-2fc969b34e49)

## Nº Validators missing blocks 

**celestia_consensus_missing_validators** 

Validator signatures are essential to validate and ensure the integrity of blocks on the blockchain. This metric can provide information on how many validators are not actively participating in the consensus process at any given time. A low or zero value is desirable, as it suggests high participation and cooperation of validators in the network. 

Value: number of validators who did not sign in the Celestia consensus system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/41b993fc-a560-4c6c-a426-c35be74d82f7)

##  Total bonded tokens  

**celestia_consensus_validators_power**  

A measure indicating the total combined power of all active validators in the Celestia consensus system. The power of validators refers to their collective influence on the consensus process and can be determined by several factors, such as the amount of participation in the network, the reputation of the validator and other criteria set by the consensus protocol. This metric provides an overview of the accumulated power of validators in the network at a given time, which can be useful for assessing the security and robustness of the consensus system.

Value: number representing the total power of all validators in the Celestia consensus system.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/de94b3c0-55d8-43a9-be37-cbe1ef890830)

##  Consensus Validators  

**celestia_consensus_validators{job="$job"}**

Total number of active validators in the Celestia consensus

Value: number of active validators

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/72495e12-3998-4012-8c9d-e00787656a57)

##  Consensus Step Duration 

**celestia_consensus_step_duration_seconds_bucket**

This metric provides detailed information on the time spent on each step of the consensus process in the Celestia system. 

Value: histogram recording the time spent on each step of the consensus process in the Celestia system.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/a53e2e61-2c54-4e6b-b69f-eb5ca9fb5011)

##  Block Processing Time  

**increase(celestia_state_block_processing_time_sum[$__rate_interval])**

This metric records the time taken by Celestia to process a status block, from BeginBlock to EndBlock, measured in milliseconds. It represents the total duration of operations performed during the processing of the status block in the Celestia system. A high value may indicate slower processing, which could affect the ability of the network to maintain optimal performance.

Value: time between BeginBlock and EndBlock in milliseconds in the Celestia system.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/ce7f059f-d9a6-4f82-8fb8-298e55afe546)

##  Interval between Consensus Blocks  

**celestia_consensus_block_interval_seconds_bucket**

This metric records the time that elapses between the production of consecutive blocks in the Celestia system, measured in seconds. It helps to understand how often new blocks are being generated in the network. For example, if there is a bucket for intervals of up to 10 seconds, it means that most blocks are being produced in that time period or less. This can be useful for assessing the efficiency and speed of the block generation process in the network.

Value: Histogram recording the time between consecutive blocks in seconds in the Celestia system.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/0f5b8cdc-1d0e-48d8-b795-f5fb45a76673)

##  Number of block parts received  

**celestia_consensus_block_gossip_parts_received** 

This metric counts the number of block parts received by a node in the Celestia system through gossip messages. Each share may or may not be relevant to the block that the node is currently collecting, and this information is recorded with the matches_current tag. This can be useful to monitor the amount of data the node is receiving during the block gathering process and to understand whether the received parties are relevant to the current block.

Value: number of block parts received by the node

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/5c3b114e-b765-4bdd-9490-9f9edb2f7591)

##  Block Interval Seconds Sum

**celestia_consensus_block_interval_seconds_sum**

This metric represents the sum total of the time elapsed between consecutive blocks in the Celestia system, measured in seconds. It provides a cumulative view of the time spent between the production of each pair of successive blocks. A higher value could indicate a slowdown in block production or longer intervals between blocks.

Value: time between consecutive blocks in the Celestia system, measured in seconds

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/daf51068-0f50-4a35-a6f4-f00921ae1e87)

##  Block Interval Seconds Count  

**celestia_consensus_block_interval_seconds_count**

Total number of times a time interval between blocks has been observed in the Celestia system. It provides a measure of how often blocks are produced in the network. A higher count may indicate high block generation activity, while a low count may indicate block generation problems or long intervals between blocks.

Value: total number of times a time interval between blocks has been observed in the Celestia system

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/4da6a869-1fd1-4a23-a018-06b987c2ba59)

##  Mempool size 

**celestia_mempool_size** 

Shows how many transactions are currently pending confirmation in the mempool, i.e. how many transactions are waiting to be included in a block.

Value: number of transactions pending confirmation that have not yet been included in a block

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/a2b4bd1e-18c2-4ce1-ba4e-b8ba02636942)


##  Duplicate Transactions in Mempool  

**celestia_mempool_already_seen_txs** 

Number of transactions that have entered the mempool in the Celestia system, but were already present in the mempool at the time. Essentially, these transactions are not new, as they have been observed before and are kept in the mempool. This can be useful in understanding the efficiency of handling duplicate transactions in the system. 

Value: number of transactions already present in the mempool 

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/616bb9c8-2de9-4e8e-9072-129375d2ad67)

## Mempool Size Bytes  

**celestia_mempool_size_bytes**

Total size of the mempool in bytes in the Celestia system. The mempool stores transactions pending processing before they are included in a block and added to the blockchain. A larger mempool may indicate high transaction activity or network congestion, while a smaller mempool may indicate lower activity or transaction processing efficiency.

Value: total mempool size in bytes

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/85271cd9-4e6d-42ab-8cb1-174bdec5d4b8)

## Mempool tx Size Bytes Sum 

**celestia_mempool_tx_size_bytes_sum**

The sum total of the size of all transactions in bytes present in the Celestia system mempool. It provides a measure of the total volume of transaction data pending processing on the network. A larger transaction size may indicate complex transactions or transactions with a large amount of attached data. 

Value: total sum of the size of all transactions in bytes in the mempool

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/70763bef-023c-4692-a104-8895c112380a)

## Txs evicted mempool 

**celestia_mempool_evicted_txs**

Number of transactions expelled from the mempool because they have reached the end of their useful lifetime

Value: number of transactions ejected from the mempool due to reaching the time to live (TTL)

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/f0296d0d-af49-4eb8-aea9-afef78953119)

## Txs failed mempool

**celestia_mempool_failed_txs** 

This metric indicates how many transactions have failed to be added ("added") to the mempool and how many have failed to be rechecked.

Value: number of transactions that have failed in the mempool. 

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/306ff534-2171-47ea-a214-b1e31b44e2d7)

## Nº Revisions in the Mempool 

**celestia_mempool_recheck_times**

Indicates how many times transactions have been reviewed again in the mempool before being included in a block or ejected.

Value: number of times transactions are reviewed again in the mempool.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/86faa4b5-0d5b-40e1-ac38-4dd531a16544)

## Process CPU Seconds Total

**process_cpu_seconds_total**

This metric records the total time, in seconds, spent by both the user and the operating system in executing a specific process.

Value: total time in CPU seconds consumed by the process since its start.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/af673f3f-c608-4983-a78e-d6961c264796)

## Current Process Virtual Memory Usage

**process_virtual_memory_bytes**

Total amount of virtual memory used by the process in bytes

Value: number indicating the size of virtual memory in bytes

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/0af2e720-45d9-469b-964e-52d36e53cd6b)

## Current Process Resident Memory Usage 

**process_resident_memory_bytes**

This metric records the size of resident memory in bytes used by the process.

Value: Size of resident memory in bytes used by the process.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/871c02a8-843e-443d-ae71-1eec1535dd79)

## Duration of Garbage Collection Pauses in Go 

**go_gc_duration_seconds_sum** 

This metric is useful for monitoring rubbish collector performance in programs written in Go, which can help identify potential bottlenecks or performance issues related to memory management.

Value: value of the cumulative sum of the durations of refuse collection breaks.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/ff1950ff-b631-44ad-9132-1b3c59d889af)

