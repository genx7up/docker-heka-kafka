cd /opt/heka
mkdir -p externals/heka-kafka
cp -r build/heka/src/github.com/genx7up/heka-kafka/* externals/heka-kafka/
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka :local)' > cmake/plugin_loader.cmake

echo 'cd /opt/heka && source build.sh && rm -rf /var/cache/hekad/logstreamer/LogstreamerInput && /opt/heka/build/heka/bin/hekad --config=/opt/heka/hekad.toml' > rebuild.sh
chmod +x rebuild.sh
./rebuild.sh
