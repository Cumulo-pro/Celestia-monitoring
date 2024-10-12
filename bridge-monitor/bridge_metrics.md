### Bridge Metrics

1. [Bridge height](#bridge-height)
2. [Node version](#node-version)
3. [Time Started Bridge node](#time-started-bridge-node)
4. [Node Chain-id](#node-chain-id)
5. [Canonical Peer Status](#canonical-peer-status)
6. [Full Peer Count](#full-peer-count)
7. [Archival Peer Count](#archival-peer-count)
8. [Wantlist Size](#wantlist-size)
9. [Overflow Size](#overflow-size)
10. [SYNC STATUS](#sync-status)
11. [Num Timeout Connectivity](#num-timeout-connectivity)
12. [Last Timeout Connectivity](#last-timeout-connectivity)
13. [Num Connection closed by remote host](#num-connection-closed-by-remote-host)
14. [Time Last Connection closed by remote host](#time-last-connection-closed-by-remote-host)
15. [Bridge Uptime (in seconds)](#bridge-uptime-in-seconds)

---

## Bridge height

*bridge_height*

Bridge node block height.

Value: numerical value representing the block height.

---

## Node version

*latest_node_version*

Latest installed version of the node.

Value: version string representing the running version.

---

## Time Started Bridge node

*bridge_start_date*

Date/time of last node reboot.

Value: Unix timestamp.

---

## Node Chain-id

*node_chain_id*

Returns the chain-id of the node.

Value: 0 – mocha, 1 - celestia.

---

## Canonical Peer Status

*connection_status*

Peer-to-peer (P2P) outgoing connection status. Returns the most recent status of the celestia-bridge service connection. If the status is ‘established,’ it indicates that the connection has been successfully established.

Value: numerical value, 1 if established.

---

## Full Peer Count

*full_peer_count*

The number of full peers connected to the Celestia bridge node.

Value: numerical value representing the number of full peers.

---

## Archival Peer Count

*archival_peer_count*

The number of archival peers connected to the Celestia bridge node.

Value: numerical value representing the number of archival peers.

---

## Wantlist Size

*wantlist_size*

The current size of the wantlist in the Celestia bridge node, representing the number of blocks requested by the node.

Value: numerical value representing the wantlist size.

---

## Overflow Size

*overflow_size*

The current size of the overflow list in the Celestia bridge node.

Value: numerical value representing the overflow size.

---

## SYNC STATUS

*sync_status*

Consensus node syncing. Either NO SYNC (not block syncing) or SYNC (syncing).

---

## Num Timeout Connectivity

*timeout_errors*

The number of times network connectivity has timed out.

Value: numerical value representing the number of timeout errors.

---

## Last Timeout Connectivity

*last_timeout_error_date*

The timestamp (in milliseconds) from the last network connectivity timeout error.

Value: timestamp representing the last timeout error.

---

## Num Connection closed by remote host

*connections_closed*

The number of connections closed by the remote host.

Value: numerical value representing the number of closed connections.

---

## Time Last Connection closed by remote host

*time_last_err_timeout_connectivity*

Timestamp representing the time of the last connection closed by the remote host.

Value: Unix timestamp of the last closed connection.

---

## Bridge Uptime (in seconds)

*bridge_uptime_seconds*

The total uptime of the Celestia bridge node in seconds since the last restart.

Value: numerical value representing the uptime in seconds.
