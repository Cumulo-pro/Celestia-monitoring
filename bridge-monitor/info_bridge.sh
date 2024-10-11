#!/bin/bash

# Ruta al archivo de métricas de node_exporter
metrics_file="/usr/local/metrics/node_exporter_metrics.prom"

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

# Obtener la última versión del nodo (Latest Node Version)
latest_node_version=$(sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1 | awk -F'node version: *' '{print $2}')
# Definir HELP y TYPE para la versión del nodo en Prometheus
{
    echo "# HELP latest_node_version The latest running version of the Celestia node"
    echo "# TYPE latest_node_version gauge"
    echo "latest_node_version_info{version=\"$latest_node_version\"} 1"
} >> "$metrics_file"

# Obtener la altura actual del bloque desde el RPC externo
rpc_url="https://mocha.celestia.rpc.cumulo.me/"
current_block_rpc=$(curl -s -X POST $rpc_url -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":1,"method":"block","params":[]} ' | jq -r '.result.block.header.height')

# Definir HELP y TYPE para la altura del bloque en el RPC en Prometheus
{
    echo "# HELP current_block_rpc Current block height from RPC"
    echo "# TYPE current_block_rpc gauge"
    echo "current_block_rpc $current_block_rpc"
} >> "$metrics_file"
