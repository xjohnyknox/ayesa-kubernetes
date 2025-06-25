#!/bin/bash


export ETCDCTL_API=3
etcdctl snapshot save \
 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
   --key=/etc/kubernetes/pki/etcd/server.key \  --endpoints=127.0.0.1:2379 /opt/etcd-backup.db