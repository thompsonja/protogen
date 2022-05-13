FROM ubuntu:20.04

ARG PROTOC_VERSION="3.12.4"

RUN apt-get update && apt-get install -y unzip wget

RUN mkdir /tmp/proto \
  && wget -qO /tmp/proto/protoc.zip \
    "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip" \
  && unzip /tmp/proto/protoc.zip -d /tmp/proto \
  && mv /tmp/proto/include/google /usr/local/include/ \
  && mv /tmp/proto/bin/protoc /usr/local/bin/protoc \
  && chmod 755 /usr/local/bin/protoc \
  && chmod -R 755 /usr/local/include/google \
  && rm -rf /tmp/proto

COPY npm.sh /opt/
RUN /opt/npm.sh && rm /opt/npm.sh
