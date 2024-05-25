# Monitoring a Celestia consensus node with Grafana and Prometheus


This is a step-by-step tutorial on how to set up the monitoring of a consensus node & validator for the Celestia blockchain, with Prometheus and Grafana.


_________________________________________________________________________________________________________________

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

____________________________________________________________________________________________________________

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

_____________________________________________________________________________________________________

## Create an account on Grafana
It is advisable to create an account on the Grafana web platform to be able to access documentation, download dashboards and other plugins, etc.  
[Grafana](https://grafana.com/)

## Install Grafana
Install some dependencies for Grafana.
```bash
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
```
Now update the repositories of your package
```bash
echo "deb https://packages.grafana.com/enterprise/deb estable main "| sudo tee -a /etc/apt/sources.list.d/grafana.list
```
Now create the user to manage Grafana.
```bash
sudo useradd -m -s /bin/bash grafana
sudo groupadd --system Grafana
sudo usermod -aG Grafana grafana
```
Install Grafana and update your packages
```bash
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.3.2_amd64.deb
sudo dpkg -i grafana-enterprise_9.3.2_amd64.deb
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/441d7e1d-e7d6-4891-bba9-10932ac40767)

**Start the server with SystemD**
To start the service and verify that it has started:
```bash
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
```

Configure the Grafana server to start at boot time:
```bash
sudo systemctl enable grafana-server.service
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/531adddf-2cab-4977-bb9b-625cc8a47786)

Now open a web browser and navigate to http://your_grafana_ip:3000 and you should see the Grafana home page. 
To log in your initial username is admin and your password is admin.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/aa4b260c-c4f0-4ed7-a92f-b4379fa87939)

The next step will ask you to change your password:
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/a40217cb-f1a3-4d1d-a85b-5f7db315acca)

After changing your password, log in to the Grafana website to download a dashboard in JSON format.
You can search or download our Celestia Consensus metrics by Cumulo dashboard to continue this tutorial :-)
[Grafana Consensus Metrics](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/grafana_consensus%20/grafana_consensus_metrics.md)

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/4874894b-a4d2-4090-a270-64aa6c3ca51b)

Go back to the Grafana page of your server and click on Configuration and then Data Sources.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b2a18e7e-326b-4d63-ae54-7f527119877d)

Now click on Add data source and select the Prometheus data source.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/a5eea04b-8da2-4bd0-8f12-28fc39bf9098)

Now enter the IP address with port 9090. If you have decided to run Prometheus and Grafana on the same server, type http://localhost:9090
If you have separated Grafana and Prometheus into two servers, then enter the IP address of Prometheus.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/0919db0e-9168-4ab8-a0e6-4dc4936bddcd)

Scroll to the bottom and click the Save & Test button.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b5adf022-72c4-4603-87db-48316fa71eff)

If you have entered the correct IP and your Prometheus firewall is open on port 9090, you will see a successful connection indicator.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/c5b8f8a5-bca0-4e67-bfbd-770986fbbf53)

Now click on Dashboard and then on Manage:
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/a34abcaa-8550-4d02-b5a0-1720c0667f20)

Now click on Import and then on Upload JSON file.
Upload the JSON file you downloaded earlier, then select the Prometheus data source you just configured and click the +Import button.
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/57ff3cca-fadf-4790-9ab4-e6ceb9c4d451)

Congratulations! You now have a control panel, for the moment it has no data:
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/f9778e0d-508c-4932-bc92-96a3e7831130)

Now we have to configure the panel to start displaying data.

_____________________________________________________________________________________________

## Setting up Prometheus  
Go back to your Prometheus server and edit the prometheus.yml file.

```bash
sudo vi /etc/prometheus/prometheus.yml
```

Enter the following parameters, the prometheus.yml file should look like this:
```bash
- job_name: celestia-consensus
  static_configs:
  - targets: ['xx.xx.xxx.xxx:26660']
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/8f5a566b-aebc-499a-a831-377f20b9ab34)

Once you have successfully pasted your code, press ESC, then press wq! keys to save the file.
Restart the Prometheus service and it will start collecting data.
```bash
sudo systemctl stop prometheus
sudo systemctl start prometheus
sudo journalctl -u prometheus -f --no-hostname -o cat
```
![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/e4b31f7b-badd-4655-95fb-e701d8b47d89)

______________________________________________________________________________________________________

## Final adjustments  
Now we have our Celestia dashboard installed, we only have to configure some parameters to read the data from our validator, in the Job variable that appears in the top left corner choose the service: celestia-consensus.

![image](https://github.com/Cumulo-pro/Celestia-monitoring/assets/2853158/b9cd127c-0168-4419-ad57-71ee572de275)

You can now start modifying or creating your own metrics with the following documentation:
[Grafana Consensus Metrics](https://github.com/Cumulo-pro/Celestia-monitoring/blob/main/grafana_consensus%20/grafana_consensus_metrics.md)
