#!/bin/bash

# Create a temporary directory
TMP_DIR=$(mktemp -d -t go-update-XXXXXX)
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

# Fetch the installed and latest Go versions, stripping 'go' prefix for comparison
if command -v go &> /dev/null; then
    INSTALLED_VERSION=$(go version | grep -o 'go[0-9.]*' | sed 's/go//' | tr -d '\n')
else
    INSTALLED_VERSION="none"
fi

LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -o 'go[0-9.]*' | sed 's/go//')
LATEST_URL="https://go.dev/dl/go${LATEST_VERSION}.linux-${GOARCH}.tar.gz"

# Check if update is needed
if [ "$INSTALLED_VERSION" = "$LATEST_VERSION" ]; then
    echo "Go is already up-to-date ($INSTALLED_VERSION). No update needed."
    # Clean up the temporary directory before exiting
    rm -rf "$TMP_DIR"
    exit 0
fi

# Debug output for versions
echo "Installed Go version: $INSTALLED_VERSION"
echo "Latest Go version: $LATEST_VERSION"
echo "Download URL: $LATEST_URL"

# Download the latest Go version
wget "$LATEST_URL" -O go_latest.tar.gz

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Extract the downloaded tarball to /usr/local
sudo tar -C /usr/local -xzf go_latest.tar.gz

# Clean up by removing the tarball
rm go_latest.tar.gz

# Verify the updated installation
go version

# Clean up the temporary directory
rm -rf "$TMP_DIR"