#!/bin/bash


multipass launch -c 1 -m 1G -d 4G -n k3s-master 18.04 \
&& multipass launch -c 1 -m 1G -d 4G -n k3s-worker-1 18.04 && 
\ multipass launch -c 1 -m 1G -d 4G -n k3s-worker-2 18.04


multipass exec k3s-master -- bash -c "curl -sfL https://get.k3s.io | sh -"

TOKEN=$(multipass exec k3s-master sudo cat /var/lib/rancher/k3s/server/node-token)

IP=$(multipass info k3s-master | grep IPv4 | awk '{print $2}')

 for f in 1 2; do
     multipass exec k3s-worker-$f -- bash -c "curl -sfL https://get.k3s.io | K3S_URL=\"https://$IP:6443\" K3S_TOKEN=\"$TOKEN\" sh -"
 done

 