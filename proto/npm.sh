#!/bin/bash

set -euo pipefail

declare -r NVM_INSTALL_VERSION="0.39.1"
declare -r NVM_INSTALL_SHASUM="fabc489b39a5e9c999c7cab4d281cdbbcbad10ec2f8b9a7f7144ad701b6bfdc7"
declare -r NODE_VERSION="16"
declare -r ANGULAR_VERSION="13.3.5"

# Export used by the nvm install script
export NVM_DIR="/usr/local/nvm"
mkdir -p "${NVM_DIR}"

# Download nvm install script, verify shasum, and run it
wget -qO install.sh \
  "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_INSTALL_VERSION}/install.sh"
echo "${NVM_INSTALL_SHASUM}  install.sh" | sha256sum -c
chmod +x install.sh
./install.sh
rm install.sh

# Add file to load whenever running ./tools/docker/run.sh /bin/bash -l
cat << EOF > /etc/profile.d/nvm.sh
#!/usr/bin/env bash
export NVM_DIR="${NVM_DIR}"

# Load nvm
[[ -s "\$NVM_DIR/nvm.sh" ]] && \. "\$NVM_DIR/nvm.sh"
EOF
chmod +x /etc/profile.d/nvm.sh

# Load nvm, install node and angular CLI
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
nvm install "${NODE_VERSION}"
nvm use "${NODE_VERSION}"
npm install -g ts-protoc-gen@0.15.0
npm install -g @improbable-eng/grpc-web@0.15.0
npm install -g @types/google-protobuf@3.15.6
npm install -g google-protobuf@3.20.1

chmod 775 -R "${NVM_DIR}"
