# Go Installation and Update Tools

This repository contains both shell scripts and Ansible playbooks for installing and updating Go on Linux systems. You can choose either method based on your needs.

## Repository Structure

```
.
└── go/
    ├── install-go.yml   # Ansible playbook for installation
    ├── install.sh       # Shell script for installation
    ├── README.md        # This documentation
    ├── update-go.yml    # Ansible playbook for updates
    └── update.sh        # Shell script for updates
```

## Method 1: Shell Scripts

### Installation

To install Go using the shell script:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go/install.sh)"
```

### Update

To update an existing Go installation:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go/update.sh)"
```

## Method 2: Ansible Playbooks

### Prerequisites for Ansible Method

- Ansible installed on the control node
- SSH access to target hosts
- Sudo privileges on target hosts

### Installation

1. Clone this repository or download the `install-go.yml` file
2. Run the installation playbook:

```bash
ansible-playbook -i inventory install-go.yml
```

### Update

1. Clone this repository or download the `update-go.yml` file
2. Run the update playbook:

```bash
ansible-playbook -i inventory update-go.yml
```

## Features

Both methods (shell scripts and Ansible playbooks) provide:

- Automatic architecture detection (amd64/arm64)
- Latest Go version installation
- Existing installation detection
- Environment variable setup
- Clean temporary files
- Easy update process

## Environment Variables

Both methods will configure the following environment variables:

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

## Shell Scripts vs Ansible Playbooks

### Shell Scripts
- Quick and easy to use
- No additional dependencies needed
- Good for single-server setups
- Simple to execute with curl

### Ansible Playbooks
- Better for multiple servers
- Idempotent execution
- Better error handling
- Infrastructure as Code approach
- Good for automation pipelines

## Troubleshooting

Common issues and solutions:

1. **Architecture not supported**
   - Check if your system is x86_64 or aarch64
   - Use `uname -m` to verify architecture

2. **Permission denied**
   - Ensure you have sudo privileges
   - Check file permissions

3. **Download fails**
   - Verify internet connection
   - Check if go.dev is accessible

4. **Environment variables not working**
   - Source your shell configuration file
   - Verify the `/etc/profile.d/go.sh` file exists

## Notes

- The installation script will not overwrite an existing Go installation
- The update script will remove the old Go installation before installing the new version
- Both scripts create and clean up temporary directories automatically
- Ansible playbooks are idempotent and can be safely run multiple times

## Contributing

Feel free to submit issues and pull requests for improvements to either the shell scripts or Ansible playbooks.