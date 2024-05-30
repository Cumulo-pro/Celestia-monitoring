# Bridge Metrics

__________________________________________________________________________________

## Bridge height

*bridge_height*

Bridge node block height

Value: numerical value representing the block

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/1f0ed3f2-b2a1-445a-9677-ec79c2202dcd)

## Node version

*last_vers_danode*

Last installed version of the node

Value: numerical value representing last version

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/982b75f9-82e6-44ab-8a7b-ee7c3c1f29c3)

## Time Started Bridge node

*time_since_celestia_danode_started*

Date/time of last node reboot

Value: Num second from last reboot

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/43992472-1f2f-4852-b011-506c89920e13)

## Node Chain-id

*chain_id_danode*

Returns the chain-id of the node

Value: 0 – mocha, 1 - celestia

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b49aabde-b59f-49c4-b52a-bea49c386a26)

## Canonical Peer Status

*connection_status*

Peer-to-peer (P2P) outgoing connection status. Returns the most recent status of the celestia-bridge service connection. If the status is ‘established’ it indicates that the connection has been successfully established.

Value: numerical value, 1 is established

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/28733321-9ed9-405a-b178-fdcb99e309b8)

## Consensus Height

*celestia_consensus_height*

Current height of the block in the Celestia consensus system

Value: numerical value representing the block

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b477fd8e-ddd1-457b-9f6a-71898ebaacb4)

## SYNC STATUS

*celestia_consensus_fast_syncing*

Consensus node syncing. Either NO SYNC (not block syncing) or SYNC (syncing)

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/5e240448-24fa-4ae7-8040-1651e2d7d5e9)

## Node Last Signed Height

*celestia_consensus_validator_last_signed_height*

Last height the node signed a block, if consensus node is a validator
Value: The recommended value for the consensus node connected to the bridge is NO VALIDATOR

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/439286c1-e26c-40d0-94ec-e29b0d32d20b)

## State Syncing

*celestia_consensus_state_syncing*

Indicates whether a consensus node is synchronising its state

Value: FALSE for synchronised nodes

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/241548f6-3c73-4615-aa4c-93a063ab6015)

## Num Timeout Connectivity

*num_err_timeout_connectivity*

Number of times network connectivity has timed out

Value: numerical value representing number times time out

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/9e7416b7-e04a-4d06-9b0c-91fb2336beb9)

## Last Timeout Connectivity

*time_last_err_timeout_connectivity*

Num second from last date timeout occurred while waiting for network connectivity. Indicates that the system attempted to wait for network connectivity, but reached a timeout without success.

Value: num second from last timeout

![Uploading image.png…]()

