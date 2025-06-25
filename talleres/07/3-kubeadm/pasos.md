# Identify the taint first.
`root@controlplane:~# kubectl describe node controlplane | grep -i taint`

# Remove the taint with help of "kubectl taint" command.
`root@controlplane:~# kubectl taint node controlplane node-role.kubernetes.io/control-plane:NoSchedule-`

# Verify it, the taint has been removed successfully.
`root@controlplane:~# kubectl describe node controlplane | grep -i taint`


# On the master node:

```
root@controlplane:~# kubectl drain master --ignore-daemonsets
root@controlplane:~# apt update
root@controlplane:~# apt-get install kubeadm=1.27.0-00
root@controlplane:~# kubeadm upgrade plan v1.27.0
root@controlplane:~# kubeadm upgrade apply v1.27.0
root@controlplane:~# apt-get install kubelet=1.27.0-00
root@controlplane:~# systemctl daemon-reload
root@controlplane:~# systemctl restart kubelet
root@controlplane:~# kubectl uncordon controlplane
```

# Now drain the worker nodes:

`kubectl drain node01 --ignore-daemonsets`

# And SSH to the node01 and perform the below steps as follows

```
root@node01:~# apt update
root@node01:~# apt-get install kubeadm=1.27.0-00
root@node01:~# kubeadm upgrade node
root@node01:~# apt-get install kubelet=1.27.0-00
root@node01:~# systemctl daemon-reload
root@node01:~# systemctl restart kubelet
```

# Back on the controlplane node:

```
root@controlplane:~# kubectl uncordon node01
root@controlplane:~# kubectl get pods -o wide | grep gold (make sure this is scheduled on a node)
```