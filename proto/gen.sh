#!/bin/bash

set -euo pipefail

declare DIRNAME
DIRNAME="$(dirname "$(realpath "$0")")"
readonly DIRNAME

declare PROJECT_DIR
PROJECT_DIR="$(realpath "${DIRNAME}/..")"
readonly PROJECT_DIR

main() {
  for gen_script in "${PROJECT_DIR}/proto"/gen_*.sh; do
    ${gen_script}
  done
}

main "$@"
