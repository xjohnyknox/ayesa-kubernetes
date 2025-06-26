#!/bin/bash
set -euxo pipefail
# Script to install and configure MetalLB on a Kubernetes cluster
# This script assumes that you have kubectl configured and running on your cluster.
# Install metallb for LoadBalancer Service type
# Define the IP address range for metallb
METALLB_IPS="10.20.7.200-10.20.7.215"

#actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
echo "Updated kube-proxy configmap to enable strict ARP"


# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.15.2/config/manifests/metallb-native.yaml
#
# echo "Applied metallb-native.yaml successfully"
#
# # Configure metallb with IP address pool
# echo "
# apiVersion: metallb.io/v1beta1
# kind: IPAddressPool
# metadata:
#   name: first-pool
#   namespace: metallb-system
# spec:
#   addresses:
#   - ${METALLB_IPS}
# ---
# apiVersion: metallb.io/v1beta1
# kind: L2Advertisement
# metadata:
#   name: example
#   namespace: metallb-system
# " | kubectl apply -f -

