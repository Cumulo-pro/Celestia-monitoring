#!/bin/bash

# Ruta al archivo de métricas de node_exporter
metrics_file="/usr/local/metrics/node_exporter_metrics.prom"
# Ruta al archivo JSON
json_file="/home/bridge_metrics.json"

# Limpiar archivo de métricas
> "$metrics_file"

# Obtener la altura actual (Current Height)
height=$(journalctl -u celestia-bridge.service -q | grep 'INFO.*header/store.*new head' | tail -n 1 | awk -F 'height": ' '{print $2}' | awk -F ',' '{print $1}')
# Definir HELP y TYPE para Prometheus
{
    echo "# HELP bridge_height Bridge node block height"
    echo "# TYPE bridge_height gauge"
    echo "bridge_height $height"
} >> "$metrics_file"

# Obtener el hash de la altura actual (Hash Current Height)
hash_current_height=$(sudo journalctl -u celestia-bridge.service | grep 'new head' | tail -n 1 | awk -F 'hash": "' '{print $2}' | awk -F '"' '{print $1}')
# Definir HELP y TYPE para el hash como un tipo "info" en Prometheus
{
    echo "# HELP bridge_height_hash Hash of current block height"
    echo "# TYPE bridge_height_hash gauge"
    echo "bridge_height_hash_info{hash=\"$hash_current_height\"} 1"
} >> "$metrics_file"

# Intentar obtener la versión del nodo (Latest Node Version) desde el Bridge
latest_node_version=$(sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1 | awk -F'node version: *' '{print $2}')

# Si no se obtiene el valor, leerlo del archivo JSON
if [ -z "$latest_node_version" ]; then
    # Extraer el valor del archivo JSON
    latest_node_version=$(jq -r '.latest_node_version' "$json_file")
fi

# Definir HELP y TYPE para la versión del nodo como tipo "info" en Prometheus
{
    echo "# HELP latest_node_version The latest running version of the Celestia node"
    echo "# TYPE latest_node_version gauge"
    echo "latest_node_version_info{version=\"$latest_node_version\"} 1"
} >> "$metrics_file"

# Obtener el chain_id del nodo (0 es mocha-4, 1 es celestia)
node_chain_id=$(sudo journalctl -u celestia-bridge.service | grep "network:" | awk '{if ($NF == "mocha-4") print 0; else if ($NF == "celestia") print 1}' | tail -n 1)

# Definir HELP y TYPE para el chain_id en Prometheus
{
    echo "# HELP node_chain_id Current chain ID of the Celestia bridge node (0 for mocha-4, 1 for celestia)"
    echo "# TYPE node_chain_id gauge"
    echo "node_chain_id $node_chain_id"
} >> "$metrics_file"

# Obtener la altura actual del bloque desde el RPC de Celestia
rpc_url="https://mocha.celestia.rpc.cumulo.me/"
current_block_rpc=$(curl -s -X POST $rpc_url -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"status"}' | jq -r '.result.sync_info.latest_block_height')

# Definir HELP y TYPE para el bloque actual del RPC en Prometheus
{
    echo "# HELP current_block_rpc Current block height from RPC"
    echo "# TYPE current_block_rpc gauge"
    echo "current_block_rpc $current_block_rpc"
} >> "$metrics_file"

# Obtener la fecha de inicio del nodo de Celestia (en formato Unix)
start_date=$(sudo journalctl -u celestia-bridge.service | grep "Started celestia DA node" | tail -n 1 | awk '{print $1, $2, $3}' | xargs -I{} date -d "{}" +"%s")

# Definir HELP y TYPE para la fecha de inicio del nodo en Prometheus
{
    echo "# HELP celestia_node_start_date Start date of the Celestia bridge node (Unix timestamp)"
    echo "# TYPE celestia_node_start_date gauge"
    echo "celestia_node_start_date $start_date"
} >> "$metrics_file"

# Guardar los valores en un archivo JSON
cat <<EOF > "$json_file"
{
    "bridge_height": "$height",
    "bridge_height_hash": "$hash_current_height",
    "latest_node_version": "$latest_node_version",
    "current_block_rpc": "$current_block_rpc",
    "node_chain_id": "$node_chain_id",
    "celestia_node_start_date": "$start_date"
}
EOF
