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

# Check if Go is already installed
if command -v go &> /dev/null; then
    INSTALLED_VERSION=$(go version | grep -o 'go[0-9.]*' | sed 's/go//' | tr -d '\n')
    echo "Go is already installed (version $INSTALLED_VERSION). No installation needed."
    # Clean up the temporary directory before exiting
    rm -rf "$TMP_DIR"
    exit 0
fi

# Fetch the latest Go version and download URL
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | grep -o 'go[0-9.]*')
LATEST_URL="https://go.dev/dl/${LATEST_VERSION}.linux-${GOARCH}.tar.gz"

# Debugging output to verify correctness
echo "Latest Go version: $LATEST_VERSION"
echo "Download URL: $LATEST_URL"

# Download the latest Go version
wget "$LATEST_URL" -O go_latest.tar.gz

# Extract the downloaded tarball
sudo tar -C /usr/local -xzf go_latest.tar.gz

# Clean up by removing the tarball
rm go_latest.tar.gz

# Inform the user that the installation is complete.
echo "Go has been successfully installed."

# Determine the user's shell and provide environment variable setup instructions
current_shell=$(basename "$SHELL")
if [ "$current_shell" = "zsh" ]; then
    echo ""
    echo "To set up Go environment variables, add the following lines to your .zshrc file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo ""
    echo "Then run 'source ~/.zshrc' to apply the changes."
elif [ "$current_shell" = "bash" ]; then
    echo ""
    echo "To set up Go environment variables, add the following lines to your .bashrc file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo ""
    echo "Then run 'source ~/.bashrc' to apply the changes."
else
    echo ""
    echo "To set up Go environment variables, add the following lines to your shell's profile file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo ""
    echo "Then source the profile file to apply the changes."
fi

# Clean up the temporary directory
rm -rf "$TMP_DIR"