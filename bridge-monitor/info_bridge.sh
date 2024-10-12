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

# Obtener la ruta del directorio de almacenamiento del nodo Celestia
node_store_path="$HOME/.celestia-bridge-mocha-4"

# Obtener la ID del nodo (Node ID) usando la ruta de almacenamiento con sudo
node_id=$(sudo /usr/local/bin/celestia p2p info --node.store "$node_store_path" 2>&1)

# Depuración del resultado bruto
echo "DEBUG: Raw output from celestia command: $node_id"

# Extraer el valor correcto utilizando jq si no hay errores
node_id_parsed=$(echo "$node_id" | jq -r '.result.id')

# Verificar si jq falló al analizar el resultado
if [ $? -ne 0 ] || [ -z "$node_id_parsed" ] || [ "$node_id_parsed" = "null" ]; then
    echo "ERROR: Failed to parse Node ID from celestia output. Using fallback from JSON."
    node_id=$(jq -r '.node_id' "$json_file")
    echo "DEBUG: Node ID from JSON is $node_id"
else
    echo "DEBUG: Node ID from celestia is $node_id_parsed"
    node_id="$node_id_parsed"
fi

# Escribir en el archivo de métricas temporal
sudo bash -c "{
    echo '# HELP node_id_info Node ID of the Celestia bridge node'
    echo '# TYPE node_id_info gauge'
    echo 'node_id_info{id=\"$node_id\"} 1'
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

# Obtener la fecha del último error de conectividad de red (Last network connectivity timeout error date)
last_timeout_error_date=$(sudo journalctl -p err | awk '/Timeout occurred while waiting for network connectivity/ {date=$1 " " $2 " " $3} END {print date}' | xargs -I {} date -d "{}" +%s)

# Convertir el timestamp de segundos a milisegundos
last_timeout_error_date_ms=$((last_timeout_error_date * 1000))

sudo bash -c "{
    echo '# HELP last_timeout_error_date Timestamp of the last network connectivity timeout error'
    echo '# TYPE last_timeout_error_date gauge'
    echo 'last_timeout_error_date $last_timeout_error_date_ms'
} >> $temp_metrics_file"

# Mover el archivo temporal al archivo final
sudo mv $temp_metrics_file $metrics_file

# Guardar los valores en un archivo JSON
sudo bash -c "cat <<EOF > $json_file
{
    \"bridge_height\": \"$height\",
    \"node_id\": \"$node_id\",
    \"bridge_height_hash\": \"$hash_current_height\",
    \"latest_node_version\": \"$latest_node_version\",
    \"current_block_rpc\": \"$current_block_rpc\",
    \"node_chain_id\": \"$node_chain_id\",
    \"connection_status\": \"$connection_status_value\",
    \"bridge_start_date\": \"$bridge_start_date\",
    \"timeout_errors\": \"$timeout_errors\",
    \"connections_closed\": \"$connections_closed\",
    \"bridge_uptime_seconds\": \"$bridge_uptime_seconds\",
    \"last_timeout_error_date\": \"$last_timeout_error_date\"
}
EOF"
