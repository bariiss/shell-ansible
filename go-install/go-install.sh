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

# Fetch the installed and latest Go versions, stripping 'go' prefix for comparison
if command -v go &> /dev/null; then
    INSTALLED_VERSION=$(go version | grep -o 'go[0-9.]*' | sed 's/go//' | tr -d '\n')
else
    INSTALLED_VERSION="none"
fi

# Check if Go is already installed
if [ "$INSTALLED_VERSION" != "none" ]; then
    echo "Go is already installed ($INSTALLED_VERSION)."
    # Clean up the temporary directory before exiting
    rm -rf "$TMP_DIR"
    exit 0
fi

# Debugging output to verify correctness
echo "Latest Go version: $LATEST_VERSION"
echo "Download URL: $LATEST_URL"

# Download the latest Go version
wget $LATEST_URL -O go_latest.tar.gz

# Extract the downloaded tarball
sudo tar -C /usr/local -xzf go_latest.tar.gz

# Clean up by removing the tarball
rm go_latest.tar.gz

# Tell the user that the installation is complete.
echo "Go has been successfully installed."

# Determine the user's shell and provide environment variable setup instructions
current_shell=$(basename "$SHELL")
if [ "$current_shell" = "zsh" ]; then
    echo -e "\nTo set up Go environment variables, add the following lines to your .zshrc file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo -e "\nThen run 'source ~/.zshrc' to apply the changes."
elif [ "$current_shell" = "bash" ]; then
    echo -e "\nTo set up Go environment variables, add the following lines to your .bashrc file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo -e "\nThen run 'source ~/.bashrc' to apply the changes."
else
    echo -e "\nTo set up Go environment variables, add the following lines to your shell's profile file:"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=$HOME/go'
    echo 'export PATH=$PATH:$GOPATH/bin'
    echo -e "\nThen source the profile file to apply the changes."
fi

# Clean up the temporary directory
rm -rf "$TMP_DIR"