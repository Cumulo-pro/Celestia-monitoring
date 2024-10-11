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
