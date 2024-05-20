#!/bin/bash

TMP_DIR=$(mktemp -d -t go-install-XXXXXX)

cd "$TMP_DIR" || exit

# Detect the CPU architecture
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
    GOARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    GOARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Fetch the latest Go version
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -o 'go[0-9.]*')
LATEST_URL="https://go.dev/dl/${LATEST_VERSION}.linux-${GOARCH}.tar.gz"

# Debugging output to verify correctness
echo "Latest Go version: $LATEST_VERSION"
echo "Download URL: $LATEST_URL"

# Download the latest Go version
wget $LATEST_URL -O go_latest.tar.gz

# Extract the downloaded tarball
sudo tar -C /usr/local -xzf go_latest.tar.gz

# Clean up by removing the tarball
rm go_latest.tar.gz

# Function to add environment variables to the specified file if not already present
add_env_vars() {
  local file=$1
  touch "$file"
  if ! grep -q '/usr/local/go/bin' "$file"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$file"
  fi
  if ! grep -q '\$HOME/go' "$file"; then
    echo 'export GOPATH=$HOME/go' >> "$file"
    echo 'export PATH=$PATH:$GOPATH/bin' >> "$file"
  fi
}

# Detect the current shell
current_shell=$(basename "$SHELL")

# Update the profile files based on the current shell
case "$current_shell" in
  bash)
    add_env_vars "$HOME/.bash_profile"
    ;;
  zsh)
    add_env_vars "$HOME/.zprofile"
    ;;
  *)
    add_env_vars "$HOME/.profile"
    ;;
esac

# Function to source profile files if they exist
source_if_exists() {
  local file=$1
  if [ -f "$file" ]; then
    . "$file"
  fi
}

# Source the profile files to apply changes
source_if_exists "$HOME/.bash_profile"
source_if_exists "$HOME/.zprofile"
source_if_exists "$HOME/.profile"

# Verify the installation
go version

# Remove the temporary directory
rm -rf "$TMP_DIR"
