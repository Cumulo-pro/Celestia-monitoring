#!/bin/bash

# node_exporter metrics file path
metrics_file="/usr/local/metrics/node_exporter_metrics.prom"

# Create the file if it does not exist
if [ ! -f "$metrics_file" ]; then
    touch "$metrics_file"
fi

# Obtain bridge height
height=$(journalctl -u celestia-bridge.service -q | grep 'INFO.*header/store.*new head' | tail -n 1 | awk -F 'height": ' '{print $2}' | awk -F ',' '{print $1}')
# Define HELP and TYPE
help_comment="# HELP bridge_height Bridge node block height "
type_comment="# TYPE bridge_height gauge"
# save
{
    echo "$help_comment"
    echo "$type_comment"
    echo "bridge_height $height"
} > "$metrics_file"

# The last version running on Celestia
last_vers_danode=$(sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1 | awk '{print substr($NF, 2)}' | tr -d '.' | awk '{print $1 / 10}')
# Define HELP y TYPE
help_comment="# HELP last_vers_danode The last version running on Celestia Bridge"
type_comment="# TYPE last_vers_danode gauge"
# Save last_vers_danode
{
    echo "$help_comment"
    echo "$type_comment"
    echo "last_vers_danode $last_vers_danode"
} >> "$metrics_file"

# Counting the number of network connectivity timeout errors
num_err_timeout_connectivity=$(sudo journalctl -p err | grep 'Timeout occurred while waiting for network connectivity' | wc -l)
# Define HELP and TYPE
help_comment="# HELP num_err_timeout_connectivity Counting the number of network connectivity timeout errors"
type_comment="# TYPE num_err_timeout_connectivity gauge"
# Save
{
    echo "$help_comment"
    echo "$type_comment"
    echo "num_err_timeout_connectivity $num_err_timeout_connectivity"
} >> "$metrics_file"



# Counting the number of closed connections per remote host
num_closed_remote_host=$(sudo journalctl -p err | grep -c 'Connection closed by remote host')

# Define HELP and TYPE for num_closed_remote_host
help_comment="# HELP num_closed_remote_host Counting the number of closed connections per remote host"
type_comment="# TYPE num_closed_remote_host gauge"

# Save num_closed_remote_host metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "num_closed_remote_host $num_closed_remote_host"
} >> "$metrics_file"

# Counting the number of time stamp analysis errors
num_failed_parse_timestamp=$(sudo journalctl -p err | grep -c "Failed to parse timestamp: '1")

# Define HELP and TYPE for num_failed_parse_timestamp
help_comment="# HELP num_failed_parse_timestamp Counting the number of time stamp analysis errors"
type_comment="# TYPE num_failed_parse_timestamp gauge"

# Save num_failed_parse_timestamp metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "num_failed_parse_timestamp $num_failed_parse_timestamp"
} >> "$metrics_file"


# Obtain connection status
status=$(sudo journalctl -u celestia-bridge.service | grep "CANONICAL_PEER_STATUS:" | awk -F'connection_status="' '{print $2}' | cut -d'"' -f1 | tail -n 1)
# Define HELP and TYPE for connection status
help_comment_status="# HELP connection_status Connection status of the bridge node (1 for established, 0 otherwise)"
type_comment_status="# TYPE connection_status gauge"
# Determine connection status value (1 if established, 0 otherwise)
if [ "$status" = "established" ]; then
    connection_status_value=1
else
    connection_status_value=0
fi
# Save
{
    echo "$help_comment_status"
    echo "$type_comment_status"
    echo "connection_status $connection_status_value"
} > "$metrics_file"

# Obtain chain_id_danode status
chain_id_danode=$(sudo journalctl -u celestia-bridge.service | grep "network:" | awk '{if ($NF == "mocha-4") print 0; else if ($NF == "celestia") print 1}' | tail -n 1)
# Define HELP and TYPE for chain_id_danode
help_comment_chain_id="# HELP chain_id_danode Network status of the bridge node (1 for celestia, 0 for mocha-4)"
type_comment_chain_id="# TYPE chain_id_danode gauge"

# Save metrics to the file
{
    echo "$help_comment_chain_id"
    echo "$type_comment_chain_id"
    echo "chain_id_danode $chain_id_danode"
} > "$metrics_file"

# Get the histogram
histogram=$(sudo journalctl -u celestia-bridge.service | awk '/-- Histogram:/ {histogram=$0; next} {if (histogram) histogram = histogram ORS $0} /--/ {print histogram; exit}')

# Extract necessary values from the histogram
min=$(echo "$histogram" | awk '/Min value:/ {print $NF}')
max=$(echo "$histogram" | awk '/Max value:/ {print $NF}')
count=$(echo "$histogram" | awk '/Count:/ {print $NF}')
p50=$(echo "$histogram" | awk '/50p:/ {print $NF}')
p75=$(echo "$histogram" | awk '/75p:/ {print $NF}')
p90=$(echo "$histogram" | awk '/90p:/ {print $NF}')

# Define HELP and TYPE for histogram metrics
help_comment="# HELP cache_life_expectancy_min Minimum value of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_min gauge"

# Save cache_life_expectancy_min metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_min $min"
} >> "$metrics_file"

help_comment="# HELP cache_life_expectancy_max Maximum value of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_max gauge"

# Save cache_life_expectancy_max metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_max $max"
} >> "$metrics_file"

help_comment="# HELP cache_life_expectancy_count Count of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_count gauge"

# Save cache_life_expectancy_count metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_count $count"
} >> "$metrics_file"

help_comment="# HELP cache_life_expectancy_p50 50th percentile of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_p50 gauge"

# Save cache_life_expectancy_p50 metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_p50 $p50"
} >> "$metrics_file"

help_comment="# HELP cache_life_expectancy_p75 75th percentile of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_p75 gauge"

# Save cache_life_expectancy_p75 metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_p75 $p75"
} >> "$metrics_file"

help_comment="# HELP cache_life_expectancy_p90 90th percentile of cache life expectancy histogram"
type_comment="# TYPE cache_life_expectancy_p90 gauge"

# Save cache_life_expectancy_p90 metrics to file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "cache_life_expectancy_p90 $p90"
} >> "$metrics_file"


# time_last_closed_remote_host
now=$(date +%s)
# Ejecutar el comando para obtener la fecha del registro del journal
journal_date=$(sudo journalctl -p err | grep 'Connection closed by remote host' | tail -n 1 | awk '{print $1, $2, $3}')
# Convertir la fecha del registro del journal en un timestamp UNIX en segundos
journal_timestamp=$(date -d "$journal_date" +%s)
# Calcular la diferencia de tiempo en segundos
difference=$((now - journal_timestamp))

# Define HELP and TYPE for the metric
help_comment="# HELP time_last_closed_remote_host Time since last connection closed by remote host"
type_comment="# TYPE time_last_closed_remote_host gauge"

# Save the metric to the metrics file
{
    echo "$help_comment"
    echo "$type_comment"
    echo "time_last_closed_remote_host $difference"
} > "$metrics_file"

# Time in seconds of last network connectivity timeout error in numeric format
timeout_connectivity_date=$(sudo journalctl -p err | grep 'Timeout occurred while waiting for network connectivity' | tail -n 1 | awk '{print $1, $2, $3}')

timeout_connectivity_timestamp=$(date -d "$timeout_connectivity_date" +%s)
now=$(date +%s)
difference=$((now - timeout_connectivity_timestamp))

# HELP & TYPE
help_comment="# HELP time_last_err_timeout_connectivity Time since last network connectivity timeout error"
type_comment="# TYPE time_last_err_timeout_connectivity gauge"

# Save
{
    echo "$help_comment"
    echo "$type_comment"
    echo "time_last_err_timeout_connectivity $difference"
} > "$metrics_file"

# Time in seconds of of the last timestamp analysis error in numeric format
closed_remote_host_date=$(sudo journalctl -p err | grep 'Connection closed by remote host' | tail -n 1 | awk '{print $1, $2, $3}')

closed_remote_host_timestamp=$(date -d "$closed_remote_host_date" +%s)
now=$(date +%s)
difference=$((now - closed_remote_host_timestamp))

# HELP & TYPE
help_comment="# HELP last_failed_parse_timestamp Time since last connection closed by remote host"
type_comment="# TYPE last_failed_parse_timestamp gauge"

# Save
{
    echo "$help_comment"
    echo "$type_comment"
    echo "last_failed_parse_timestamp $difference"
} > "$metrics_file"

# Time when celestia DA node started
date_started_danode=$(sudo journalctl -u celestia-bridge.service | grep "Started celestia DA node" | tail -n 1 | awk '{ "date -d \""$1" "$2" "$3"\" +\"%s\"" | getline date; print date}')


now=$(date +%s)
difference=$((now - date_started_danode))

# HELP & TYPE
help_comment="# HELP time_since_celestia_danode_started Time since Celestia DA node started"
type_comment="# TYPE time_since_celestia_danode_started gauge"

# Save
{
    echo "$help_comment"
    echo "$type_comment"
    echo "time_since_celestia_danode_started $difference"
} > "$metrics_file"
