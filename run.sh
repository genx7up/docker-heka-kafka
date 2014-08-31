#!/bin/bash

source build.sh

#Install Kafka Plugin
cd /opt/heka
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka 471e4c3fd521e1f694e0ea540931bd9d6f065863)' >> cmake/plugin_loader.cmake
go get github.com/Shopify/sarama
source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data
