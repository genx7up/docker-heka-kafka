FROM nclans/centos:latest

#Install Requisites
RUN yum -y install git gcc gcc-c++ make patch glibc.i686 hg unzip

#Install cmake
RUN cd /opt
RUN curl -O http://www.cmake.org/files/v3.0/cmake-3.0.1-Linux-i386.sh
RUN echo "y Y" | bash cmake-3.0.1-Linux-i386.sh
RUN export PATH=$PATH:/opt/cmake-3.0.1-Linux-i386/bin

#Install ProtoBuffers
RUN curl -o protobuf-2.5.0.zip https://protobuf.googlecode.com/files/protobuf-2.5.0.zip
RUN unzip protobuf-2.5.0.zip
RUN cd protobuf-2.5.0
RUN ./configure && make install

#Install GO
RUN curl -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

#Clone heka from latest source
RUN cd /opt
RUN git clone https://github.com/mozilla-services/heka

#Build Core
RUN cd heka
RUN source build.sh

#Build Plugin
RUN cd .. 
RUN echo 'add_external_plugin(git https://github.com/genx7up/heka-kafka 471e4c3fd521e1f694e0ea540931bd9d6f065863)' >> cmake/plugin_loader.cmake
RUN go get github.com/Shopify/sarama
RUN source build.sh

#Copy the new binary to shared volume
cp heka/bin/hekad /data