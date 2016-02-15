#!/bin/bash
set -xe

cd /opt/heka
git pull
git checkout genx7up-patch-1
rm -rf cmake/plugin_loader.cmake
source build.sh

#Install Kafka Plugin
cd /opt/heka
go get github.com/linkedin/goavro
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka aec1391b52185ca44cc728219b3629dca67b062c)' >> cmake/plugin_loader.cmake
source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data
