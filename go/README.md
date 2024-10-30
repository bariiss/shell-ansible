# Go Installation and Update Scripts

This repository contains shell scripts to easily install and update Go on Linux systems. The scripts automatically detect your system architecture and handle the installation/update process.

## Features

- Automatic architecture detection (amd64/arm64)
- Latest Go version installation
- Existing installation detection
- Environment variable setup guidance
- Clean temporary files
- Easy update process

## Quick Installation

To install Go, run:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go/install.sh)"
```

This command will:
1. Download and execute the installation script
2. Detect your system architecture
3. Install the latest version of Go
4. Provide instructions for setting up environment variables

## Updating Go

To update an existing Go installation to the latest version:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go/update.sh)"
```

The update script will:
1. Check your current Go version
2. Compare it with the latest available version
3. Update only if necessary
4. Remove the old installation and install the new version

## Post-Installation Setup

After installation, you'll need to set up your Go environment variables. The script will provide specific instructions based on your shell, but generally you'll need to add these lines to your shell's configuration file:

```bash
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

## System Requirements

- Linux operating system
- x86_64 (amd64) or aarch64 (arm64) architecture
- `curl` or `wget` installed
- sudo privileges

## Troubleshooting

If you encounter any issues:
1. Ensure you have sudo privileges
2. Check if you have sufficient disk space
3. Verify your internet connection
4. Make sure you have the required tools installed (curl, wget)

## Notes

- The installation script will not overwrite an existing Go installation
- The update script will remove the old Go installation before installing the new version
- Both scripts create and clean up temporary directories automatically