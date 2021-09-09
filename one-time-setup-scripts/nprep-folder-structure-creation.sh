#!bin/bash

sudo mkdir -p /mnt/apps/tenx
sudo mkdir -p /mnt/apps/tenx/bin
sudo mkdir -p /mnt/apps/tenx/config
sudo mkdir -p /mnt/apps/tenx/lib
sudo mkdir -p /mnt/apps/tenx/keys
sudo mkdir -p /mnt/apps/tenx/logs
sudo mkdir -p /mnt/apps/tenx/scripts
sudo mkdir -p /mnt/apps/tenx/services
sudo mkdir -p /mnt/apps/tenx/working
sudo mkdir -p /mnt/apps/ntmp
sudo ln -s /mnt/apps/ntmp /ntmp
sudo ln -s /mnt/apps/tenx /tenx
sudo mkdir -p /ntmp/zookeeper
sudo mkdir -p /ntmp/kafka-logs
sudo chmod -R 777 /mnt/apps/tenx
sudo chmod -R 777 /ntmp
sudo chmod -R 777 /mnt
sudo chmod -R 777 /mnt/apps/kafka_2.11-0.9.0.1/bin
sudo chmod -R 777 /ntmp/zookeeper
sudo chmod -R 777 /mnt/apps