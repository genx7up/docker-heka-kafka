FROM nclans/centos:latest

#Install Requisites
RUN yum -y install git gcc gcc-c++ make patch glibc.i686 hg unzip

#Install cmake
WORKDIR /opt
RUN curl -O http://www.cmake.org/files/v3.0/cmake-3.0.1-Linux-i386.sh
RUN echo "y Y" | bash cmake-3.0.1-Linux-i386.sh
ENV PATH $PATH:/opt/cmake-3.0.1-Linux-i386/bin

#Install ProtoBuffers
RUN curl -o protobuf-2.5.0.zip https://protobuf.googlecode.com/files/protobuf-2.5.0.zip
RUN unzip protobuf-2.5.0.zip
RUN cd protobuf-2.5.0 && ./configure && make && make install

#Install GO
RUN curl -o /tmp/go.tar.gz https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH $PATH:/usr/local/go/bin

#Clone heka from latest source
RUN git clone -b versions/0.7 https://github.com/mozilla-services/heka.git /opt/heka

# Define default run command.
WORKDIR /opt/heka
ADD run.sh /run.sh
CMD ["bash", "/run.sh"]
