#!/bin/bash

# Create a temporary directory
TMP_DIR=$(mktemp -d -t ansible-XXXXXX)
cd "$TMP_DIR" || exit

# Download the playbook
curl -fsSL https://raw.githubusercontent.com/bariiss/shell-ansible/main/go/install-go.yml -o install-go.yml

# Create inventory file
echo "localhost ansible_connection=local" > inventory

# Run the playbook
ansible-playbook -i inventory install-go.yml

# Clean up
rm -rf "$TMP_DIR"