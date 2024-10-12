#!/bin/bash

# Ruta al archivo de métricas de node_exporter
metrics_file="/usr/local/metrics/node_exporter_metrics.prom"
# Ruta al archivo JSON
json_file="/home/bridge_metrics.json"

# Limpiar archivo de métricas
> "$metrics_file"

# Obtener la altura actual (Current Height)
height=$(journalctl -u celestia-bridge.service -q | grep 'INFO.*header/store.*new head' | tail -n 1 | awk -F 'height": ' '{print $2}' | awk -F ',' '{print $1}')
if [ -z "$height" ]; then
    height=$(jq -r '.bridge_height' "$json_file")
fi

# Definir HELP y TYPE para Prometheus
{
    echo "# HELP bridge_height Bridge node block height"
    echo "# TYPE bridge_height gauge"
    echo "bridge_height $height"
} >> "$metrics_file"

# Obtener el hash de la altura actual (Hash Current Height)
hash_current_height=$(sudo journalctl -u celestia-bridge.service | grep 'new head' | tail -n 1 | awk -F 'hash": "' '{print $2}' | awk -F '"' '{print $1}')
if [ -z "$hash_current_height" ]; then
    hash_current_height=$(jq -r '.bridge_height_hash' "$json_file")
fi

{
    echo "# HELP bridge_height_hash Hash of current block height"
    echo "# TYPE bridge_height_hash gauge"
    echo "bridge_height_hash_info{hash=\"$hash_current_height\"} 1"
} >> "$metrics_file"

# Obtener la altura actual del bloque desde el RPC de Celestia
rpc_url="https://mocha.celestia.rpc.cumulo.me/"
current_block_rpc=$(curl -s -X POST $rpc_url -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"status"}' | jq -r '.result.sync_info.latest_block_height')
if [ -z "$current_block_rpc" ]; then
    current_block_rpc=$(jq -r '.current_block_rpc' "$json_file")
fi

{
    echo "# HELP current_block_rpc Current block height from RPC"
    echo "# TYPE current_block_rpc gauge"
    echo "current_block_rpc $current_block_rpc"
} >> "$metrics_file"

# Intentar obtener la versión del nodo (Latest Node Version) desde el Bridge
latest_node_version=$(sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1 | awk -F'node version: *' '{print $2}')
if [ -z "$latest_node_version" ]; then
    latest_node_version=$(jq -r '.latest_node_version' "$json_file")
fi

{
    echo "# HELP latest_node_version The latest running version of the Celestia node"
    echo "# TYPE latest_node_version gauge"
    echo "latest_node_version_info{version=\"$latest_node_version\"} 1"
} >> "$metrics_file"

# Obtener el chain_id del nodo (0 es mocha-4, 1 es celestia)
node_chain_id=$(sudo journalctl -u celestia-bridge.service | grep "network:" | awk '{if ($NF == "mocha-4") print 0; else if ($NF == "celestia") print 1}' | tail -n 1)
if [ -z "$node_chain_id" ]; then
    node_chain_id=$(jq -r '.node_chain_id' "$json_file")
fi

{
    echo "# HELP node_chain_id Current chain ID of the Celestia bridge node (0 for mocha-4, 1 for celestia)"
    echo "# TYPE node_chain_id gauge"
    echo "node_chain_id $node_chain_id"
} >> "$metrics_file"

# Obtener el estado de la conexión (Connection Status)
connection_status=$(sudo journalctl -u celestia-bridge.service | grep "CANONICAL_PEER_STATUS:" | awk -F'connection_status="' '{print $2}' | cut -d'"' -f1 | tail -n 1)

# Convertir el estado a 1 si es "established", de lo contrario 0
if [ "$connection_status" = "established" ]; then
    connection_status_value=1
else
    connection_status_value=0
fi

{
    echo "# HELP connection_status Status of the connection (1 for established, 0 otherwise)"
    echo "# TYPE connection_status gauge"
    echo "connection_status $connection_status_value"
} >> "$metrics_file"

# Obtener la fecha de inicio del nodo Celestia Bridge (Bridge Node Start Date)
bridge_start_date=$(sudo journalctl -u celestia-bridge.service | grep "Started celestia DA node" | tail -n 1 | awk '{print $1 " " $2 " " $3}' | xargs -I {} date -d "{}" +%s)
if [ -z "$bridge_start_date" ]; then
    bridge_start_date=$(jq -r '.bridge_start_date' "$json_file")
fi

{
    echo "# HELP bridge_start_date Timestamp of when Celestia DA node started"
    echo "# TYPE bridge_start_date gauge"
    echo "bridge_start_date $bridge_start_date"
} >> "$metrics_file"

# Obtener el número de errores de tiempo de espera de conectividad de red (Number of network connectivity timeout errors)
timeout_errors=$(sudo journalctl -p err | grep 'Timeout occurred while waiting for network connectivity' | wc -l)

{
    echo "# HELP timeout_errors Number of network connectivity timeout errors"
    echo "# TYPE timeout_errors gauge"
    echo "timeout_errors $timeout_errors"
} >> "$metrics_file"

# Obtener el número de conexiones cerradas por el host remoto (Number of connections closed by remote host)
connections_closed=$(sudo journalctl -p err | grep -c 'Connection closed by remote host')

{
    echo "# HELP connections_closed Number of connections closed by the remote host"
    echo "# TYPE connections_closed gauge"
    echo "connections_closed $connections_closed"
} >> "$metrics_file"

# Guardar los valores en un archivo JSON
cat <<EOF > "$json_file"
{
    "bridge_height": "$height",
    "bridge_height_hash": "$hash_current_height",
    "latest_node_version": "$latest_node_version",
    "current_block_rpc": "$current_block_rpc",
    "node_chain_id": "$node_chain_id",
    "connection_status": "$connection_status_value",
    "bridge_start_date": "$bridge_start_date",
    "timeout_errors": "$timeout_errors",
    "connections_closed": "$connections_closed"
}
EOF
