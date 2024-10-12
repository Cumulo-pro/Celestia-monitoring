#!/bin/bash

# Ruta al archivo de métricas de node_exporter
metrics_file="/usr/local/metrics/node_exporter_metrics.prom"
# Ruta al archivo temporal
temp_metrics_file="/usr/local/metrics/node_exporter_metrics_temp.prom"
# Ruta al archivo JSON
json_file="/home/bridge_metrics.json"

# Limpiar archivo de métricas temporal
> "$temp_metrics_file"

# Obtener la altura actual (Current Height)
height=$(journalctl -u celestia-bridge.service -q | grep 'INFO.*header/store.*new head' | tail -n 1 | awk -F 'height": ' '{print $2}' | awk -F ',' '{print $1}')
if [ -z "$height" ]; then
    height=$(jq -r '.bridge_height' "$json_file")
fi

# Escribir en el archivo de métricas temporal
sudo bash -c "{
    echo '# HELP bridge_height Bridge node block height'
    echo '# TYPE bridge_height gauge'
    echo 'bridge_height $height'
} >> $temp_metrics_file"

# Obtener el hash de la altura actual (Hash Current Height)
hash_current_height=$(sudo journalctl -u celestia-bridge.service | grep 'new head' | tail -n 1 | awk -F 'hash": "' '{print $2}' | awk -F '"' '{print $1}')
if [ -z "$hash_current_height" ];then
    hash_current_height=$(jq -r '.bridge_height_hash' "$json_file")
fi

sudo bash -c "{
    echo '# HELP bridge_height_hash Hash of current block height'
    echo '# TYPE bridge_height_hash gauge'
    echo 'bridge_height_hash_info{hash=\"$hash_current_height\"} 1'
} >> $temp_metrics_file"

# Obtener la altura actual del bloque desde el RPC de Celestia
rpc_url="https://mocha.celestia.rpc.cumulo.me/"
current_block_rpc=$(curl -s -X POST $rpc_url -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"status"}' | jq -r '.result.sync_info.latest_block_height')
if [ -z "$current_block_rpc" ];then
    current_block_rpc=$(jq -r '.current_block_rpc' "$json_file")
fi

sudo bash -c "{
    echo '# HELP current_block_rpc Current block height from RPC'
    echo '# TYPE current_block_rpc gauge'
    echo 'current_block_rpc $current_block_rpc'
} >> $temp_metrics_file"

# Intentar obtener la versión del nodo (Latest Node Version) desde el Bridge
latest_node_version=$(sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1 | awk -F'node version: *' '{print $2}')
if [ -z "$latest_node_version" ];then
    latest_node_version=$(jq -r '.latest_node_version' "$json_file")
fi

sudo bash -c "{
    echo '# HELP latest_node_version The latest running version of the Celestia node'
    echo '# TYPE latest_node_version gauge'
    echo 'latest_node_version_info{version=\"$latest_node_version\"} 1'
} >> $temp_metrics_file"

# Obtener el chain_id del nodo (0 es mocha-4, 1 es celestia)
node_chain_id=$(sudo journalctl -u celestia-bridge.service | grep "network:" | awk '{if ($NF == "mocha-4") print 0; else if ($NF == "celestia") print 1}' | tail -n 1)
if [ -z "$node_chain_id" ];then
    node_chain_id=$(jq -r '.node_chain_id' "$json_file")
fi

sudo bash -c "{
    echo '# HELP node_chain_id Current chain ID of the Celestia bridge node (0 for mocha-4, 1 for celestia)'
    echo '# TYPE node_chain_id gauge'
    echo 'node_chain_id $node_chain_id'
} >> $temp_metrics_file"

# Obtener el estado de la conexión (Connection Status)
connection_status=$(sudo journalctl -u celestia-bridge.service | grep "CANONICAL_PEER_STATUS:" | awk -F'connection_status="' '{print $2}' | cut -d'"' -f1 | tail -n 1)

# Convertir el estado a 1 si es "established", de lo contrario 0
if [ "$connection_status" = "established" ];then
    connection_status_value=1
else
    connection_status_value=0
fi

sudo bash -c "{
    echo '# HELP connection_status Status of the connection (1 for established, 0 otherwise)'
    echo '# TYPE connection_status gauge'
    echo 'connection_status $connection_status_value'
} >> $temp_metrics_file"

# Obtener la fecha de inicio del nodo Celestia Bridge (Bridge Node Start Date)
bridge_start_date=$(sudo journalctl -u celestia-bridge.service | grep "Started celestia DA node" | tail -n 1 | awk '{print $1 " " $2 " " $3}' | xargs -I {} date -d "{}" +%s)
if [ -z "$bridge_start_date" ];then
    bridge_start_date=$(jq -r '.bridge_start_date' "$json_file")
fi

# Obtener el tiempo actual
current_time=$(date +%s)
# Calcular el tiempo de actividad en segundos
bridge_uptime_seconds=$((current_time - bridge_start_date))

sudo bash -c "{
    echo '# HELP bridge_uptime_seconds Total uptime of the Celestia bridge node in seconds'
    echo '# TYPE bridge_uptime_seconds gauge'
    echo 'bridge_uptime_seconds $bridge_uptime_seconds'
} >> $temp_metrics_file"

# Obtener el número de errores de tiempo de espera de conectividad de red (Number of network connectivity timeout errors)
timeout_errors=$(sudo journalctl -p err | grep 'Timeout occurred while waiting for network connectivity' | wc -l)

sudo bash -c "{
    echo '# HELP timeout_errors Number of network connectivity timeout errors'
    echo '# TYPE timeout_errors gauge'
    echo 'timeout_errors $timeout_errors'
} >> $temp_metrics_file"

# Obtener el número de conexiones cerradas por el host remoto (Number of connections closed by remote host)
connections_closed=$(sudo journalctl -p err | grep -c 'Connection closed by remote host')

sudo bash -c "{
    echo '# HELP connections_closed Number of connections closed by the remote host'
    echo '# TYPE connections_closed gauge'
    echo 'connections_closed $connections_closed'
} >> $temp_metrics_file"

# Obtener el conteo de peers completos (Full Peer Count)
full_peer_count=$(sudo journalctl -u celestia-bridge.service | grep "full" | wc -l)

sudo bash -c "{
    echo '# HELP full_peer_count Number of full peers connected'
    echo '# TYPE full_peer_count gauge'
    echo 'full_peer_count $full_peer_count'
} >> $temp_metrics_file"

# Obtener el conteo de peers archivales (Archival Peer Count)
archival_peer_count=$(sudo journalctl -u celestia-bridge.service | grep "archival" | wc -l)

sudo bash -c "{
    echo '# HELP archival_peer_count Number of archival peers connected'
    echo '# TYPE archival_peer_count gauge'
    echo 'archival_peer_count $archival_peer_count'
} >> $temp_metrics_file"

# Mover el archivo temporal al archivo final
sudo mv $temp_metrics_file $metrics_file

# Guardar los valores en un archivo JSON
sudo bash -c "cat <<EOF > $json_file
{
    \"bridge_height\": \"$height\",
    \"bridge_height_hash\": \"$hash_current_height\",
    \"latest_node_version\": \"$latest_node_version\",
    \"current_block_rpc\": \"$current_block_rpc\",
    \"node_chain_id\": \"$node_chain_id\",
    \"connection_status\": \"$connection_status_value\",
    \"bridge_start_date\": \"$bridge_start_date\",
    \"timeout_errors\": \"$timeout_errors\",
    \"connections_closed\": \"$connections_closed\",
    \"bridge_uptime_seconds\": \"$bridge_uptime_seconds\",
    \"full_peer_count\": \"$full_peer_count\",
    \"archival_peer_count\": \"$archival_peer_count\"
}
EOF"
