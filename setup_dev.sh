cd /opt/heka
mkdir -p externals/heka-kafka
cp -r build/heka/src/github.com/genx7up/heka-kafka/* externals/heka-kafka/
echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka :local)' > cmake/plugin_loader.cmake

echo 'cd /opt/heka && source build.sh && rm -rf /var/cache/hekad/logstreamer/LogstreamerInput && /opt/heka/build/heka/bin/hekad --config=/opt/heka/hekad.toml' > rebuild.sh
echo 'rm -rf /var/cache/hekad/logstreamer/LogstreamerInput && /opt/heka/build/heka/bin/hekad --config=/opt/heka/hekad.toml' > testrun.sh
chmod +x rebuild.sh
chmod +x testrun.sh
./rebuild.sh

echo 'To rebuild, use ./rebuild.sh'
echo 'To simply test run, use ./testrun.sh'
