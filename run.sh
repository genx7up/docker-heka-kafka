#!/bin/bash

git pull
git checkout v0.9.2
source build.sh

#Install Kafka Plugin
cd /opt/heka
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka 7cbdd308fc4e7875603ee7725b33b116f0131017)' >> cmake/plugin_loader.cmake
go get github.com/linkedin/goavro
source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data
