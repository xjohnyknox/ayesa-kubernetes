# Ejercicios Dia 06.

En este dia, tenemos los siguientes ejercicios:

- [Ejercicios Dia 06.](#ejercicios-dia-06)
  - [1-node-labels](#1-node-labels)
  - [2-node-selector](#2-node-selector)
  - [3-pod-con-node-affinity](#3-pod-con-node-affinity)
  - [4-antiaffinity](#4-antiaffinity)
  - [5-pod-affinity](#5-pod-affinity)
  - [6-node-name](#6-node-name)
  - [7-pod-con-topology-spread](#7-pod-con-topology-spread)
  - [8-taint-a-un-nodo](#8-taint-a-un-nodo)
  - [9-resource-management](#9-resource-management)


## 1-node-labels

Vamos a ver qué labels ya tienen nuestros nodos:

Ejecutamos el vagrant con 2 nodos, modificando el archivo de [settings.yaml](https://github.com/xjohnyknox/ayesa-kubernetes/blob/main/laboratorio/settings.yaml#L24):
`  workers:
    count: 2`

Aplicamos el cambio:

`vagrant up`

Luego revisamos con:

`kubectl get nodes --show-labels`

Y comenta, cuáles de esta lista aparecieron?

- [ ] kubernetes.io/arch
- [ ] kubernetes.io/hostname
- [ ] kubernetes.io/os

Y pega en el archivo: `respuesta_aqui.txt` la información.

## 2-node-selector

De los nodos que tiene tu cluster, vamos a agregar una etiqueta extra a 1 nodo (elije cuál):

`kubectl label nodes NOMBRE disco=ssd`

Ahora revisemos que si quedó:

`kubectl get nodes --show-labels | grep disco`


Ahora, en la carpeta ahi un fichero, revisalo y despliegalo.

`kubectl apply -f ejercicio1.yaml`

Y revisa en que nodo fue ubicado ese pod:

`kubectl get pods -o wide`

Ahora, edita el archivo `2.yaml`, para que se despliegue este otro pod en tu otro nodo (cambia su **nodeName**)

Revisa que si funciono.

Si ya todo esta listo, ahora elimina el label que pusimos anteriormente:


```
kubectl label nodes NOMBRE disco-
node/node01 unlabeled
```
> disco fue la label que pusimos antes, y el signo menos (-) la elimina.

## 3-pod-con-node-affinity

Ahora vamos a desplegar un pod con node affinity.

`kubectl apply -f pod-con-node-affinity.yaml`

Y aqui vamos a ver que luego de crear la label: `app=frontend `en 1 nodo, el nodeAffinity, tratara de darle prioridad a ese nodo, pero sino, igual lo agenda.

(Hagamos la prueba de poner una label que NO existe)

## 4-antiaffinity

Aqui vemos como usando los operadores NotIn, o DoesNotExist creamos una regla antiaffinity

## 5-pod-affinity

Aqui vemos como podemos para algo mas cutomizado, crear una regla de afinidad para un pod en específico, en vez de aplicarla a un nodo

## 6-node-name

Averigua el nombre de un nodo worker, ahora pon ese nombre en el archivo `node-name.yaml`, despliegalo y verifica que si este sirviendo.

## 7-pod-con-topology-spread

Para que funcione, vamos a crear un pod con las etiquetas que el manifiesto va a evadir:

`kubectl run prueba-7 --image httpd -l app=mi-app`

Y ahora si, aplico el manifiesto, y veo que en el nodo donde se asigno el pod prueba-7, no hay un pod llamado `pod-con-topology-spread`

## 8-taint-a-un-nodo

Vamos a hacer un taint a un nodo:
`kubectl taint nodes NODO key=value:NoSchedule`

`kubectl describe node NODO | grep Taint`

Aplicamos el manifiesto `1-toleration-pod.yaml`.

Y revisemos si lo agendo en el nodo que lo tolera:

`kubectl get pods -o wide`

**toleration-pod-no-execute**

Ahora vamos a ver como es asignar un pod a un nodo en modo: **No-Execute**

`kubectl taint nodes NODO key=value:NoExecute`

Y apliquemos el manifiesto del `2-toleration-pod-no-execute.yaml`.

Y revisa que el pod no esta corriendo.

Ahora quita ese `Taint`, del nodo y vuelve a correr el pod.

`kubectl taint nodes NODO key=value:NoExecute-`

Ahora si corre, porque no hay mas Taints sobre ese efecto: `NoExecute`.

## 9-resource-management

Vamos a poner límites a memoria y CPU de un pod.

`1-poniendo-limites.yaml`

Revisa que si esté con los limites seteados en el pod.


Ahora vamos a usar el comando de stress para bombardear el pod con mas del CPU que tenemos seteado:

`kubectl exec -it 1-poniendo-limites -- bash`

`stress --cpu 900m`

Y revisemos si salió el error de `OOMKilled`

Ahora probemos la memoria

`stress --vm 100 --vm-bytes 256M`
