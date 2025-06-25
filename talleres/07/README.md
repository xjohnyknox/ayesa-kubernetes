# Ejercicios Dia 07.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 07.](#ejercicios-dia-07)
  - [1-preparando-el-ambiente](#1-preparando-el-ambiente)
  - [2-backup-etcd](#2-backup-etcd)
  - [3-kubeadm](#3-kubeadm)
  - [4-drain](#4-drain)


## 1-preparando-el-ambiente

Vamos a necesitar 3 nodos, uno master y dos workers.

Listamos para saber que estan las 3 máquinas corriendo:

```
❯  kubectl get nodes -o wide
Name                    State             IPv4             Image
k3s-master              Running           192.168.65.4     Ubuntu 22.04 LTS
k3s-worker-1            Running           192.168.65.5     Ubuntu 22.04 LTS
k3s-worker-2            Running           192.168.65.6     Ubuntu 22.04 LTS
```



## 2-backup-etcd

Por ahora es solo la información.

## 3-kubeadm

Pasos para poder hacer el upgrade de la versión de k8s.

## 4-drain

Vamos a acordonar un nodo:

`kubectl cordon node02`

Vamos a investigar qué ocurre.

Ahora, quitemosle el cordon:

`kubectl uncordon node02`

Ahora vamos a drenar un nodo y ver como saca los pods de ese nodo:

`kubectl drain node-02 --ignore-daemonsets`

