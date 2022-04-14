#!/bin/bash

set -euxo pipefail

declare DIRNAME
DIRNAME="$(dirname "$(realpath "$0")")"
readonly DIRNAME

declare PROJECT_DIR
PROJECT_DIR="${PROJECT_DIR:-"$(realpath "${DIRNAME}/..")"}"
readonly PROJECT_DIR

declare DOCKER_IMAGE="dartproto:latest"

# Protobuf dir containing Google pb files
declare -r GOOGLE_PB_DIR="${GOOGLE_PB_DIR:-"/usr/local/include/google/protobuf"}"
# Protobuf dir containing source pb files, relative to project dir
declare -r SOURCE_PB_DIR="${SOURCE_PB_DIR:-"proto"}"
# Destination dir for generated proto pb.dart files, relative to project dir
declare -r PB_DIR="${PB_DIR:-"frontend/lib/proto"}"
# Flutter wants all libs to be in the source tree, copy google pb files here.
# This is relative to PB_DIR
declare -r IN_PROJECT_GOOGLE_PB_DIR="${IN_PROJECT_GOOGLE_PB_DIR:-"google/protobuf"}"

install_and_activate_dart_protoc_plugin() {
  if ! command -v protoc-gen-dart >/dev/null; then
    pub global activate protoc_plugin
    export PATH="${PATH}:/${HOME}/.pub-cache/bin"
  fi
}

gen_dart_protobuf() {
  install_and_activate_dart_protoc_plugin

  local -r abs_pb_dir="${PROJECT_DIR}/${PB_DIR}"
  local -r abs_src_pb_dir="${PROJECT_DIR}/${SOURCE_PB_DIR}"
  local -r abs_google_pb_dir="${abs_pb_dir}/${IN_PROJECT_GOOGLE_PB_DIR}"

  rm -rf "${abs_pb_dir}"
  mkdir -p "${abs_pb_dir}/google/protobuf"

  echo "Generating protobuf code for dart"

  for proto in $(find "${GOOGLE_PB_DIR}" -name "*.proto" \
      | sed 's/.*google\/protobuf\///'); do
    local proto_name
    proto_name="$(basename "${proto}")"
    proto_name="${proto_name%.*}"
    local proto_dir
    proto_dir="$(dirname "${proto}")"

    local local_proto_dir
    local_proto_dir="${abs_google_pb_dir}/${proto_dir}"
    mkdir -p "${local_proto_dir}"

    cp "${GOOGLE_PB_DIR}/${proto}" "${local_proto_dir}"

    set -x
    # Running protoc on all files at once didn't seem to work...
    protoc \
      -I"${abs_google_pb_dir}" \
      --dart_out=grpc,generate_kythe_info:"${abs_google_pb_dir}" \
      "${proto}"
    set +x

    # Replace import paths in google proto files, they are all colocated
    sed -i -e "s/import \(.*\)google\/protobuf\//import \1/g" \
      "${local_proto_dir}/${proto_name}.pb.dart"
  done

  set -x
  protoc \
    -I"${abs_src_pb_dir}" \
    --dart_out=grpc,generate_kythe_info:"${abs_pb_dir}" \
    "${abs_src_pb_dir}/"*.proto
  set +x

  echo "Done!"
}

main() {
  # Ensure we run this script inside a docker container
  if [[ ! -f "/.dockerenv" ]]; then
    # Create a fake home directory and mount it as HOME in the docker container.
    # Do this to avoid polluting the user's HOME directory with a lot of
    # extraneous directories, like ~/.pub_cache, etc.
    local -r fakehome="${HOME}/.fakehome"
    mkdir -p "${fakehome}"
    docker build -t "${DOCKER_IMAGE}" -f "${DIRNAME}/Dockerfile.dart" "${DIRNAME}"
    docker run --rm \
      --volume="${fakehome}:${fakehome}" \
      --volume="${PROJECT_DIR}:${PROJECT_DIR}" \
      --workdir="${PROJECT_DIR}" \
      "--user" "$(id -u):$(id -g)" \
      "-e" "USER=$(id -run)" \
      "-e" "HOME=${fakehome}" \
      "-v" "GOOGLE_PB_DIR=${GOOGLE_PB_DIR}" \
      "-v" "SOURCE_PB_DIR=${SOURCE_PB_DIR}" \
      "-v" "PB_DIR=${PB_DIR}" \
      "-v" "IN_PROJECT_GOOGLE_PB_DIR=${IN_PROJECT_GOOGLE_PB_DIR}" \
      "${DOCKER_IMAGE}" \
      ./proto/gen_dart.sh
  else
    gen_dart_protobuf
  fi
}

main
