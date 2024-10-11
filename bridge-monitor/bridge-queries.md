# CLI queries to a Celestia bridge node

height of the block:  
```bash
journalctl -u celestia-bridge.service -q | grep 'INFO.*header/store.*new head' | tail -n 1 | awk -F 'height": ' '{print $2}' | awk -F ',' '{print $1}'
```

latest bridge node version:  
```bash
sudo journalctl -u celestia-bridge.service | grep "node version:" | tail -n 1
```

connection status:  
```bash
sudo journalctl -u celestia-bridge.service | grep "CANONICAL_PEER_STATUS:" | awk -F'connection_status="' '{print $2}' | cut -d'"' -f1 | tail -n 1
```

node chain_id (0 is mocha-4, 1 is celestia):  
```bash
sudo journalctl -u celestia-bridge.service | grep "network:" | awk '{if ($NF == "mocha-4") print 0; else if ($NF == "celestia") print 1}' | tail -n 1
```

Celestia's bridge node start date:  
```bash
sudo journalctl -u celestia-bridge.service | grep "Started celestia DA node" | tail -n 1 | awk '{ "date -d \""$1" "$2" "$3"\" +\"%s\"" | getline date; print date}'
```

Number of network connectivity timeout errors:  
```bash
sudo journalctl -p err | grep 'Timeout occurred while waiting for network connectivity' | wc -l
```

Number of connections closed by the remote host:  
```bash
sudo journalctl -p err | grep -c 'Connection closed by remote host'
```

Last network connectivity timeout error date:  
```bash
sudo journalctl -p err | awk '/Timeout occurred while waiting for network connectivity/ {date=$1 " " $2 " " $3} END {print date}'
```


