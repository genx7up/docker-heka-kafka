#!/bin/bash

git pull
git checkout v0.9.2
source build.sh

#Install Kafka Plugin
cd /opt/heka
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka ffdae590cb5f611aece01d27dbe5cfd2632229bf)' >> cmake/plugin_loader.cmake
source build.sh

#Copy the new binary to shared volume
cp build/heka/bin/hekad /data
