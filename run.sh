#!/bin/bash

git pull
git checkout v0.7.1
source build.sh

#Install Kafka Plugin
cd /opt/heka
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka acf3ac7a3d6d6dab313510f81828fca2f9375229)' >> cmake/plugin_loader.cmake
go get github.com/Shopify/sarama
source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data
