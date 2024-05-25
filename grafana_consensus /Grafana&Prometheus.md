# Monitoring a Celestia consensus node with Grafana and Prometheus


This is a step-by-step tutorial on how to set up the monitoring of a consensus node & validator for the Celestia blockchain, with Prometheus and Grafana.

## First steps
✔️ Before you start, you need to make sure that prometheus is enabled in your validator node by checking the value of the variable in:
.celestia-app/config/config.toml  

```prometheus=true```   

✔️ Specify your listening port (26660) and be sure to open it in your Firewall.
✔️ Change namespace to the value: celestia  

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/7e0b3b15-d05b-486c-a8c3-907c6e0973c8)

NOTE: It is not recommended that you run Prometheus on the same server as a validator because you may lose blocks due to competing system resources.

For the configuration to be applied you must restart your node.
If everything went well, we will be able to see the Prometheus results of our node at the following address:

```http://(ip node Celestia): 26660```

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/d75f2c4c-0d9f-4170-ad9e-5c0e3199a9a8)

## Install Prometheus
Official website: https://prometheus.io/
Create a prometheus user that will be used to run Prometheus.

```bash
sudo useradd -m -s /bin/bash Prometheus 
sudo groupadd --system Prometheus  
sudo usermod -aG Prometheus Prometheus  
```
Now do some file system cleanup and then download and install Prometheus.

```bash
sudo mkdir /var/lib/prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
mkdir -p /tmp/prometheus && cd /tmp/prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi

sudo mkdir /var/lib/prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
mkdir -p /tmp/prometheus && cd /tmp/prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi

tar xvf prometheus*.tar.gz
cd prometheus*/
sudo mv prometheus promtool /usr/local/bin/
```

Once the download is complete and Prometheus is unpacked, verify that Prometheus and Promtool are operational. You will see version numbers for both if you successfully completed the above steps.
```bash
prometheus –-version
promtool –-version
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/9ce45ee2-a919-4477-9b51-45eff9c8eab8)

We establish some order by moving some files like these:
```bash
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo mv consoles/ console_libraries/ /etc/prometheus/
```

Finally, we set up Prometheus as a service to run all the time!
```bash
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=Prometheus
Group=Prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/var/lib/prometheus \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries \
--web.listen-address=0.0.0.0:9090 \
--web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```
We will configure port 9090, changing it to our desired port.
Some more order in our Prometheus files:
```bash
for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R Prometheus:Prometheus /var/lib/prometheus/
```
Now we add the Prometheus service to systemctl and then launch it.
```bash
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
```

If Prometheus is running successfully, you should have a status screen that looks like this. Press CTL+C to exit the systemctl status screen.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/7650225e-cc8b-42cd-bded-5fa5b4d6e243)

Now we can access the Prometheus interface by accessing the ip of the server where we have installed it:
**(ip node Prometheus):9090/status**
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/2e17f394-24ba-4e6a-bedc-fc405d045cb9)

You can start querying Prometheus in the Graph section, using the Celestia metrics functions, which can be found here:
[Grafana Consensus Metrics](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/grafana_consensus%20/grafana_consensus_metrics.md)

**(ip nodo Prometheus):9090/graph**
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b7679564-e665-481d-9af5-1e1ac20a0f64)

Congratulations! You now have a running Prometheus server. We'll come back to it for additional configuration.
