#!/usr/bin/env bash
|-
  ETCDCTL_API=3 etcdctl --endpoints=$ENDPOINTS --cacert=$CACERT --cert=$CERT --key=$KEY
  snapshot save /tmp/etcd-backup.db
