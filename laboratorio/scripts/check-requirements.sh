#!/bin/bash

echo "🔍 Checking system requirements for Kubernetes Vagrant cluster..."
echo

# Check Vagrant
if ! command -v vagrant &> /dev/null
then
    echo "❌ Vagrant is NOT installed. Please install Vagrant: https://www.vagrantup.com/downloads"
    exit 1
else
    echo "✅ Vagrant is installed: $(vagrant --version)"
fi

# Check VirtualBox
if ! command -v VBoxManage &> /dev/null
then
    echo "❌ VirtualBox is NOT installed or VBoxManage not found in PATH."
    echo "    Please install VirtualBox: https://www.virtualbox.org/wiki/Downloads"
    exit 1
else
    echo "✅ VirtualBox is installed: $(VBoxManage --version)"
fi

echo
echo "🎉 All requirements satisfied! You are ready to run: vagrant up"
