#!/bin/bash

set -euo pipefail

declare DIRNAME
DIRNAME="$(dirname "$(realpath "$0")")"
readonly DIRNAME

declare THIS_DIR
THIS_DIR="$(realpath "${DIRNAME}/..")"
readonly THIS_DIR

declare PROJECT_DIR
PROJECT_DIR="${PROJECT_DIR:-"$(realpath "${DIRNAME}/..")"}"
readonly PROJECT_DIR

declare DOCKER_IMAGE="tsproto:latest"

# Protobuf dir containing source pb files, relative to project dir
declare -r SOURCE_PB_DIR="${SOURCE_PB_DIR:-"proto"}"
# Destination dir for generated proto pb.ts files, relative to project dir
# Ensure that this folder *only* contains generated code as the contents are
# deleted on each run!
declare -r PB_DIR="${PB_DIR:-"frontend_ts/genproto"}"

gen_ts_protobuf() {
  local -r abs_pb_dir="${PROJECT_DIR}/${PB_DIR}"
  local -r abs_src_pb_dir="${PROJECT_DIR}/${SOURCE_PB_DIR}"

  rm -rf "${abs_pb_dir}"
  mkdir -p "${abs_pb_dir}"

  source /etc/profile.d/nvm.sh

  echo "Generating protobuf code for typescript"
  protoc \
    --proto_path="${abs_src_pb_dir}" \
    --plugin="protoc-gen-ts=$(which protoc-gen-ts)" \
    --js_out="import_style=commonjs,binary:${abs_pb_dir}" \
    --ts_out="service=grpc-web:${abs_pb_dir}" \
    "${abs_src_pb_dir}/"*.proto
  echo "Done!"
}

main() {
  # Ensure we run this script inside a docker container
  if [[ ! -f "/.dockerenv" ]]; then
    docker build -t "${DOCKER_IMAGE}" -f "${DIRNAME}/Dockerfile.ts" "${DIRNAME}"
    docker run --rm \
      --volume="${PROJECT_DIR}:${PROJECT_DIR}" \
      --volume="${THIS_DIR}:${THIS_DIR}" \
      --workdir="${PROJECT_DIR}" \
      "--user" "$(id -u):$(id -g)" \
      "-e" "USER=$(id -run)" \
      "-e" "PROJECT_DIR=${PROJECT_DIR}" \
      "-e" "SOURCE_PB_DIR=${SOURCE_PB_DIR}" \
      "-e" "PB_DIR=${PB_DIR}" \
      "${DOCKER_IMAGE}" \
      "${THIS_DIR}/proto/gen_ts.sh"
  else
    gen_ts_protobuf
  fi
}

main
