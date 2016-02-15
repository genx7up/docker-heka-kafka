FROM nclans/centos:latest

#Install Requisites
RUN yum -y install git gcc gcc-c++ make patch glibc.i686 hg unzip

#Install cmake
WORKDIR /opt
RUN curl -O https://cmake.org/files/v3.4/cmake-3.4.3-Linux-x86_64.sh
RUN echo "y Y" | bash cmake-3.4.3-Linux-x86_64.sh
ENV PATH $PATH:/opt/cmake-3.4.3-Linux-x86_64/bin

#Install ProtoBuffers
RUN curl -o protobuf-2.5.0.zip https://protobuf.googlecode.com/files/protobuf-2.5.0.zip
RUN unzip protobuf-2.5.0.zip
RUN cd protobuf-2.5.0 && ./configure && make && make install

#Install GO
RUN curl -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.5.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH $PATH:/usr/local/go/bin

#Clone heka from latest source
RUN git clone https://github.com/genx7up/heka.git /opt/heka

# Define default run command.
WORKDIR /opt/heka
ADD run.sh /run.sh
ADD setup_dev.sh /setup_dev.sh
CMD ["bash", "/run.sh"]
