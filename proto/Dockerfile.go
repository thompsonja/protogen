FROM ubuntu:20.04

ARG PROTOC_VERSION="3.12.4"
ARG PROTOC_GEN_GO_VERSION="v1.27.1"
ARG PROTOC_GEN_GO_GRPC_VERSION="v1.1"

ENV PATH="${PATH}:/usr/local/go/bin"

RUN apt-get update && apt-get install -y unzip wget \
  && wget -q https://go.dev/dl/go1.17.6.linux-amd64.tar.gz \
  && rm -rf /usr/local/go \
  && tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz \
  && rm go1.17.6.linux-amd64.tar.gz \
  && GOBIN=/usr/local/bin/ go install "google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GEN_GO_VERSION}" \
  && GOBIN=/usr/local/bin/ go install "google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GEN_GO_GRPC_VERSION}"

RUN mkdir /tmp/proto \
  && wget -q -O /tmp/proto/protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip" \
  && unzip /tmp/proto/protoc.zip -d /tmp/proto \
  && mv /tmp/proto/include/google /usr/local/include/ \
  && mv /tmp/proto/bin/protoc /usr/local/bin/protoc \
  && chmod 755 /usr/local/bin/protoc \
  && chmod -R 755 /usr/local/include/google \
  && rm -rf /tmp/proto
