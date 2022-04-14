#!/bin/bash

set -euxo pipefail

declare DIRNAME
DIRNAME="$(dirname "$(realpath "$0")")"
readonly DIRNAME

declare PROJECT_DIR
PROJECT_DIR="${PROJECT_DIR:-"$(realpath "${DIRNAME}/..")"}"
readonly PROJECT_DIR

declare DOCKER_IMAGE="goproto:latest"

# Protobuf dir containing source pb files, relative to project dir
declare -r SOURCE_PB_DIR="${SOURCE_PB_DIR:-"proto"}"
# Destination dir for generated proto pb.go files, relative to project dir
# Ensure that this folder *only* contains generated code as the contents are
# deleted on each run!
declare -r PB_DIR="${PB_DIR:-"backend/pkg/genproto"}"

gen_go_protobuf() {
  local -r abs_pb_dir="${PROJECT_DIR}/${PB_DIR}"
  local -r abs_src_pb_dir="${PROJECT_DIR}/${SOURCE_PB_DIR}"

  rm -rf "${abs_pb_dir}"
  mkdir -p "${abs_pb_dir}"

  echo "Generating protobuf code for go"
  protoc --proto_path="${abs_src_pb_dir}" \
    --go_out="${abs_pb_dir}" \
    --go-grpc_out="${abs_pb_dir}" \
    --go_opt=paths=source_relative \
    --go-grpc_opt=paths=source_relative \
    "${abs_src_pb_dir}/"*.proto
  for f in "${abs_src_pb_dir}/"*.proto; do
    local proto_name
    proto_name="$(basename $f)"
    proto_name="${proto_name%.proto}"
    mkdir "${abs_pb_dir}/${proto_name}"
    mv "${abs_pb_dir}/${proto_name}"{_grpc,}.pb.go \
      "${abs_pb_dir}/${proto_name}"
  done
  echo "Done!"
}

main() {
  # Ensure we run this script inside a docker container
  if [[ ! -f "/.dockerenv" ]]; then
    docker build -t "${DOCKER_IMAGE}" -f "${DIRNAME}/Dockerfile.go" "${DIRNAME}"
    docker run --rm \
      --volume="${PROJECT_DIR}:${PROJECT_DIR}" \
      --workdir="${PROJECT_DIR}" \
      "--user" "$(id -u):$(id -g)" \
      "-e" "USER=$(id -run)" \
      "-e" "SOURCE_PB_DIR=${SOURCE_PB_DIR}" \
      "-e" "PB_DIR=${PB_DIR}" \
      "${DOCKER_IMAGE}" \
      ./proto/gen_go.sh
  else
    gen_go_protobuf
  fi
}

main
