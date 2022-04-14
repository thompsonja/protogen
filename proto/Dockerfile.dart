FROM ubuntu:20.04

ARG PROTOC_VERSION="3.12.4"
ARG DART_SDK_VERSION="2.16.1"
ENV PATH "$PATH:/usr/lib/dart/bin"

RUN apt-get update -y && apt-get install -y git gnupg wget unzip

RUN wget -O dart.deb "https://storage.googleapis.com/dart-archive/channels/stable/release/${DART_SDK_VERSION}/linux_packages/dart_${DART_SDK_VERSION}-1_amd64.deb" \
  && dpkg -i dart.deb \
  && rm dart.deb

# Dart protobuf setup
RUN pub global activate protoc_plugin \
  && mkdir /tmp/proto \
  && wget -O /tmp/proto/protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip" \
  && unzip /tmp/proto/protoc.zip -d /tmp/proto \
  && mv /tmp/proto/include/* /usr/local/include/ \
  && mv /tmp/proto/bin/protoc /usr/local/bin/protoc \
  && chmod 755 /usr/local/bin/protoc \
  && chmod -R 755 /usr/local/include/google \
  && rm -rf /tmp/proto
