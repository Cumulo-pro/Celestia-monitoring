# Grafana consensus & validator metrics FAQ

- [Sync Status](#sync-status)
- [State Syncing](#state-syncing)
- [Node Last Signed Height](#node-last-signed-height)
- [Node Voting Power](#node-voting-power)
- [Connected Peers & P2P Peers](#connected-peers--p2p-peers)
- [Consensus Height](#consensus-height)
- [Block Time](#block-time)
- [Block Size (bytes)](#block-size-bytes)
- [Nº Transactions Committed](#nº-transactions-committed)
- [Total Txs](#total-txs)
- [Missing Validators Power](#missing-validators-power)
- [Nº Validators Missing Blocks](#nº-validators-missing-blocks)
- [Total Bonded Tokens](#total-bonded-tokens)
- [Consensus Validators](#consensus-validators)
- [Block Processing Time](#block-processing-time)
- [Number of Block Parts Received](#number-of-block-parts-received)
- [Mempool Size](#mempool-size)
- [Duplicate Transactions in Mempool](#duplicate-transactions-in-mempool)
- [Mempool tx Size Bytes Sum](#mempool-tx-size-bytes-sum)
- [Mempool Size Bytes](#mempool-size-bytes)
- [Txs Failed Mempool](#txs-failed-mempool)
- [Mempool Recheck Times](#mempool-recheck-times)
- [Process CPU Seconds Total](#process-cpu-seconds-total)
- [Current Process Virtual Memory Usage](#current-process-virtual-memory-usage)
- [Current Process Resident Memory Usage](#current-process-resident-memory-usage)
- [Go GC Duration](#go-gc-duration)

---

## SYNC STATUS

**celestia_consensus_fast_syncing**: `1` means the node is syncing blocks; `0` means it's fully synced.

## STATE SYNCING

**celestia_consensus_state_syncing**: Indicates if the node is syncing state snapshots.

## NODE LAST SIGNED HEIGHT

**celestia_consensus_validator_last_signed_height**: Last height signed by the validator.

## NODE VOTING POWER

**celestia_consensus_validator_power**: Voting power of the validator.

## CONNECTED PEERS & P2P PEERS

**celestia_p2p_peers**: Number of P2P peers connected.

## CONSENSUS HEIGHT

**celestia_consensus_height**: Current block height according to consensus.

## BLOCK TIME

**celestia_consensus_block_time_seconds**: Time in seconds between consecutive blocks.

## BLOCK SIZE (BYTES)

**celestia_consensus_block_size_bytes**: Size of the last block in bytes.

## Nº TRANSACTIONS COMMITTED

**celestia_consensus_num_txs**: Number of txs in the last block.

## TOTAL TXS

**celestia_consensus_total_txs**: Cumulative tx count since genesis.

## MISSING VALIDATORS POWER

**celestia_consensus_missing_validators_power**: Total voting power of validators who missed signing.

## Nº VALIDATORS MISSING BLOCKS

**celestia_consensus_missing_validators**: Number of validators who missed block signatures.

## TOTAL BONDED TOKENS

**celestia_consensus_validators_power**: Total power of all active validators.

## CONSENSUS VALIDATORS

**celestia_consensus_validators**: Number of active validators in the consensus set.

## BLOCK PROCESSING TIME

**celestia_state_block_processing_time_sum** / **_count**: Total time spent in FinalizeBlock execution.

## NUMBER OF BLOCK PARTS RECEIVED

**celestia_consensus_block_gossip_parts_received**: Block parts received from peers.

## MEMPOOL SIZE

**celestia_mempool_size**: Number of txs currently pending in the mempool.

## DUPLICATE TRANSACTIONS IN MEMPOOL

**celestia_mempool_already_seen_txs**: Number of duplicated txs in mempool.

## MEMPOOL TX SIZE BYTES SUM

**celestia_mempool_tx_size_bytes_sum**: Total size in bytes of all txs in the mempool.

## MEMPOOL SIZE BYTES

**celestia_mempool_size_bytes**: Total byte size of mempool.

## TXS FAILED MEMPOOL

**celestia_mempool_failed_txs**: Number of txs that failed to enter the mempool.

## MEMPOOL RECHECK TIMES

**celestia_mempool_recheck_times**: Number of times txs were rechecked in mempool.

## PROCESS CPU SECONDS TOTAL

**process_cpu_seconds_total**: CPU usage in seconds since process start.

## CURRENT PROCESS VIRTUAL MEMORY USAGE

**process_virtual_memory_bytes**: Total virtual memory used by the process.

## CURRENT PROCESS RESIDENT MEMORY USAGE

**process_resident_memory_bytes**: Resident memory in use by the node.

## GO GC DURATION

**go_gc_duration_seconds_sum**: Sum of pause durations during Go garbage collection.
