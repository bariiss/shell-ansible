# Go Installation with Ansible - Local Setup

## 1. Create Inventory File

Create a file named `inventory` in your project root:

```bash
# From the project root
echo "localhost ansible_connection=local" > inventory
```

Your file structure should look like:
```
.
└── go/
    ├── install-go.yml
    ├── install.sh
    ├── README.md
    ├── update-go.yml
    └── update.sh
└── inventory
```

## 2. Run the Playbook

Now you can run the playbook in one of two ways:

### Option 1: From project root
```bash
ansible-playbook -i inventory go/install-go.yml
```

### Option 2: From go directory
```bash
cd go
ansible-playbook -i ../inventory install-go.yml
```

## For Local Testing

If you want to test the playbook with verbose output, add the `-v` flag:
```bash
ansible-playbook -i inventory go/install-go.yml -v
```

## Common Issues

1. If you get a "Permission denied" error, add `--ask-become-pass` or `-K`:
```bash
ansible-playbook -i inventory go/install-go.yml -K
```

2. If you get Python interpreter warnings, you can specify the interpreter:
```bash
ansible-playbook -i inventory go/install-go.yml -e 'ansible_python_interpreter=/usr/bin/python3'
```

The same instructions apply for `update-go.yml` - just replace the filename in the commands.