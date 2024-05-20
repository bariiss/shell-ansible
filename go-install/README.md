# shell-ansible > go-install

# Go Installation Script

This script automates the installation of the latest version of Go, configures environment variables, and verifies the installation.

## Usage

You can run the script directly from the terminal using either `curl` or `wget`.

### Using curl

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go-install.sh)"

### Using wget

```sh
sh -c "$(wget -qO- https://raw.githubusercontent.com/bariiss/shell-ansible/main/go-install.sh)"

## What the Script Does

- Detects the CPU architecture (amd64 or arm64).
- Fetches the latest Go version.
- Downloads and extracts the latest Go tarball to /usr/local.
- Configures the environment variables (PATH and GOPATH).
- Updates the respective shell configuration files (.bashrc, .bash_profile, .zshrc, .zprofile, and .profile).
- Sources the configuration files to apply changes.
- Verifies the Go installation.
