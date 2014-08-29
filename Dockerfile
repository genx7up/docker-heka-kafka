FROM nclans/centos:latest

#Install Requisites
RUN yum -y install git gcc gcc-c++ make patch glibc.i686 hg unzip

#Install cmake
RUN cd /opt
RUN curl http://www.cmake.org/files/v3.0/cmake-3.0.1-Linux-i386.sh
RUN echo "y Y" | bash cmake-3.0.1-Linux-i386.sh
RUN export PATH=$PATH:/opt/cmake-3.0.1-Linux-i386/bin

#Install ProtoBuffers
RUN curl -o protobuf-2.5.0.zip https://protobuf.googlecode.com/files/protobuf-2.5.0.zip
RUN unzip protobuf-2.5.0.tar.gz
RUN cd protobuf-2.5.0
RUN ./configure && make install

#Install GO
RUN curl curl -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

#Clone heka from latest source
RUN cd /opt
RUN git clone https://github.com/mozilla-services/heka

#Build
RUN cd heka
RUN echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka f6f6f61bcb5a09ea0f5a58697f495ba8db52e7de)' >> cmake/plugin_loader.cmake
RUN go get github.com/Shopify/sarama
RUN source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data
