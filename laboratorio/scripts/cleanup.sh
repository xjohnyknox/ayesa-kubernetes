#!/bin/bash

echo "🧹 Cleaning up Kubernetes Vagrant cluster..."
echo

# Destroy all Vagrant VMs
vagrant destroy -f

# Optional: remove .vagrant directory
echo
echo "🗑️  Removing .vagrant directory..."
rm -rf .vagrant

echo
echo "✅ Cleanup complete! Your local environment is clean."
