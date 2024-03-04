#!/bin/bash

# Path of the output JSON file
json_file="orchestrator_test.json"
# Define the time interval to search for errors (last 5 minutes)
interval="5 min ago"

# Search for errors in logs in the last 5 minutes, cleaning ANSI escape codes
errors=$(journalctl -u orchestrator -o cat --since "$interval" | sed 's/\x1b\[[0-9;]*m//g' | grep -i "error")

# Check if errors were found
if [ -z "$errors" ]; then
    has_errors="false"
else
    has_errors="true"
fi

# Get the last "signed commitment" entry by cleaning ANSI escape codes
last_commitment=$(journalctl -u orchestrator -o cat | grep "signed commitment" | sed 's/\x1b\[[0-9;]*m//g' | tail -n 1)

# Extract values from the last "signed commitment" entry
nonce=$(echo "$last_commitment" | awk '{for(i=1;i<=NF;i++) if($i ~ /^nonce=/){print substr($i,7)}}')
begin_block=$(echo "$last_commitment" | awk '{for(i=1;i<=NF;i++) if($i ~ /^begin_block=/){print substr($i,12)}}')
end_block=$(echo "$last_commitment" | awk '{for(i=1;i<=NF;i++) if($i ~ /^end_block=/){print substr($i,10)}}')
data_root_tuple_root=$(echo "$last_commitment" | awk '{for(i=1;i<=NF;i++) if($i ~ /^data_root_tuple_root=/){print substr($i,21)}}')

# Get current UTC date and time
utc_date=$(date -u +"%Y-%m-%d %H:%M:%S")

# Get the count of errors and warnings and the full history of them
errors_history=$(journalctl -u orchestrator -o cat | grep -i "error")
warnings_history=$(journalctl -u orchestrator -o cat | grep -i "warning")
errors_count=$(echo "$errors_history" | grep -c "error")
warnings_count=$(echo "$warnings_history" | grep -c "warning")

# Generate JSON output with extracted data
jq -n \
    --arg nonce "$nonce" \
    --arg begin_block "$begin_block" \
    --arg end_block "$end_block" \
    --arg data_root_tuple_root "$data_root_tuple_root" \
    --arg utc_date "$utc_date" \
    --arg has_errors "$has_errors" \
    --arg errors_count "$errors_count" \
    --arg warnings_count "$warnings_count" \
    --arg errors_history "$errors_history" \
    --arg warnings_history "$warnings_history" \
    '{
        "nonce": $nonce,
        "begin_block": $begin_block,
        "end_block": $end_block,
        "data_root_tuple_root": $data_root_tuple_root,
        "utc_date": $utc_date,
        "has_errors": $has_errors,
        "errors_count": $errors_count,
        "warnings_count": $warnings_count,
        "errors_history": $errors_history,
        "warnings_history": $warnings_history
    }' > "$json_file"

# Show the generated JSON file
cat "$json_file"
